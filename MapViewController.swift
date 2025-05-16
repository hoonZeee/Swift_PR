//
//  ViewController.swift
//  Please
//
//  Created by 이지훈 on 5/13/25.
//

import UIKit
import KakaoMapsSDK
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate, XMLParserDelegate {
    
    
    @IBOutlet weak var mapView: KMViewContainer!
    
    
    @IBOutlet weak var busInfoView: UIView!
    
    
    @IBOutlet weak var busInfoViewBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var dragHandView: UIView!
    
    
    
    @IBOutlet weak var busStopName: UILabel!
    
    
    
    @IBOutlet weak var arrivalInfoTable: UITableView!
    
    
    
    
    
    var mapController: KMController?
    var locationManager: CLLocationManager!
    var lastKnownLocation: CLLocation?
    var selectedStopName: String?
    
    // XML 파싱 관련 변수
    var currentElement = ""
    var currentStopName = ""
    var currentGpsX = ""
    var currentGpsY = ""
    
    
    var didAddStyle = false
    
    var addedMarkerKeys = Set<String>()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // 지도 연결
        mapController = KMController(viewContainer: mapView)
        mapController?.prepareEngine()
        mapController?.activateEngine()
        
        let defaultPosition = MapPoint(longitude: 129.0756, latitude: 35.1796)
        let mapviewInfo = MapviewInfo(
            viewName: "mapview",
            viewInfoName: "map",
            defaultPosition: defaultPosition,
            defaultLevel: 17
        )
        mapController?.addView(mapviewInfo)
        
        // 위치 관련
        locationManager = CLLocationManager()
        locationManager.delegate = self                        //ViewController가 대신 처리하겠다. 위치바뀌면 업뎃하려고
        locationManager.desiredAccuracy = kCLLocationAccuracyBest           //GPS기반인데 성능좋은데, 베터리좀 먹음
        locationManager.requestWhenInUseAuthorization()                     //앱이 사용중일때만 위치 기반을 사용하도록
        locationManager.startUpdatingLocation()                             //실제 위치정보 추적
        
        
        
        fetchBusStops()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        dragHandView.addGestureRecognizer(panGesture)
        
        
        
    }
    
    func showBusInfoView() {
        busInfoViewBottomConstraint.constant = 0
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self.view)
        
        switch gesture.state {
        case .changed:
            let newConstant = busInfoViewBottomConstraint.constant - translation.y
            if newConstant <= 0 && newConstant >= -600 {
                busInfoViewBottomConstraint.constant = newConstant
                self.view.layoutIfNeeded()
            }
            gesture.setTranslation(.zero, in: self.view)
            
        case .ended, .cancelled:
            let velocity = gesture.velocity(in: self.view).y
            let shouldOpen = velocity < 0
            busInfoViewBottomConstraint.constant = shouldOpen ? 0 : -600
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
            
        default:
            break
        }
    }

    

    // 위치 수신 콜백 - 최근 위치 저장
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        lastKnownLocation = location  // 위치 저장
    }
    
    
    // 버튼 액션 - 저장된 위치로 이동

    @IBAction func moveToMyLocation(_ sender: Any) {
        guard let location = lastKnownLocation else {
            print("❗ 아직 위치를 받아오지 못했어요")
            return
        }
        moveCamera(to: location)
    }
    
    // 공통 카메라 이동 함수
    func moveCamera(to location: CLLocation) {
        let point = MapPoint(longitude: location.coordinate.longitude, latitude: location.coordinate.latitude)
        
        //UI 렌더링 부분이니까 메인스레드에서 담당
        DispatchQueue.main.async {
            if let mapView = self.mapController?.getView("mapview") as? KakaoMap {
                let cameraUpdate = CameraUpdate.make(
                    target: point,
                    zoomLevel: 17,
                    mapView: mapView
                )
                
                mapView.animateCamera(
                    cameraUpdate: cameraUpdate,
                    options: CameraAnimationOptions(autoElevation: true, consecutive: false, durationInMillis: 800)
                )
            }
        }
    }
    
    // 정류장 API 호출 함수
    func fetchBusStops() {
        let serviceKey = "TF7Mku%2BuSzYBCUtjel7ketfVE8uKj1gnPjH0fxQG1amxTSmZHTaIWBCr5qqOYQ7%2Fy5CHFp%2FvmmmeW2ITP53yHw%3D%3D"

        for page in 1...9 {
            let urlStr = "https://apis.data.go.kr/6260000/BusanBIMS/busStopList?serviceKey=\(serviceKey)&numOfRows=1000&pageNo=\(page)"
            guard let url = URL(string: urlStr) else { continue }

            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data else {
                    print("❌ 데이터 없음 (page \(page))")
                    return
                }
                let parser = XMLParser(data: data)
                parser.delegate = self
                parser.parse()
            }
            task.resume()
        }
    }
    
    
    
    func parser(_ parser: XMLParser, didStartElement elementName: String,
                namespaceURI: String?, qualifiedName qName: String?,
                attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        
        if elementName == "item" {
                // 여기서 초기화해야 새로운 item 시작할 때 값이 깨끗해짐!
                currentStopName = ""
                currentGpsX = ""
                currentGpsY = ""
            }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let trimmed = string.trimmingCharacters(in: .whitespacesAndNewlines)
        if !trimmed.isEmpty {
            print("📦 Element: \(currentElement), Value: \(trimmed)")
            switch currentElement {
            case "bstopnm": currentStopName = trimmed
            case "gpsx": currentGpsX = trimmed
            case "gpsy": currentGpsY = trimmed
            default: break
            }
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String,
                    namespaceURI: String?, qualifiedName qName: String?) {
            if elementName == "item",
               let x = Double(currentGpsX),
               let y = Double(currentGpsY) {
                
                let isValidCoord = (-90.0...90.0).contains(y) && (-180.0...180.0).contains(x)
                   guard isValidCoord else {
                       print("🚫 잘못된 좌표: \(x), \(y)")
                       return
                   }
                
                let point = MapPoint(longitude: x, latitude: y)
                
                DispatchQueue.main.async {
                    if let mapView = self.mapController?.getView("mapview") as? KakaoMap {
                        let manager = mapView.getLabelManager()
                        
                        
                        // 레이어 추가 (1회만)
                        if manager.getLabelLayer(layerID: "BusStopLayer") == nil {
                            let layerOption = LabelLayerOptions(layerID: "BusStopLayer", competitionType: .none, competitionUnit: .poi, orderType: .rank, zOrder: 10001)
                            _ = manager.addLabelLayer(option: layerOption)
                        }
                        
                        // 스타일 추가 (1회만)
                        if !self.didAddStyle {
                            if let icon = UIImage(named: "pin_red") {
                                let iconStyle = PoiIconStyle(symbol: icon, anchorPoint: CGPoint(x: 0.5, y: 1.0))
                                let levelStyle = [
                                    PerLevelPoiStyle(iconStyle: iconStyle, level: 16) // 16 이상에서만 보여짐
                                ]

                                let poiStyle = PoiStyle(styleID: "busStopStyle", styles: levelStyle)
                                manager.addPoiStyle(poiStyle)
                                self.didAddStyle = true
                            }
                        }
                        
                        // POI 생성
                        
                        let markerTitle = self.currentStopName.isEmpty ? "(이름 없음)" : self.currentStopName
                        let roundedX = Double(String(format: "%.5f", x))!
                        let roundedY = Double(String(format: "%.5f", y))!
                        let markerKey = "\(markerTitle)_\(roundedX)_\(roundedY)"
                        
                        let poiOption = PoiOptions(styleID: "busStopStyle", poiID: markerKey)
                        poiOption.clickable = true
                        poiOption.rank = 0
                        poiOption.addText(PoiText(text: self.currentStopName, styleIndex: 0))
                        
                        if let layer = manager.getLabelLayer(layerID: "BusStopLayer") {
                            
                            
                            // ✅ 중복 마커 방지
                            if self.addedMarkerKeys.contains(markerKey) {
                                print("⚠️ 이미 추가된 정류장: \(markerKey)")
                                return
                            }
                            self.addedMarkerKeys.insert(markerKey)
                            
                        
                            
                            if let poi = layer.addPoi(option: poiOption, at: point) {
                                // 마커 탭 이벤트 등록
                                _ = poi.addPoiTappedEventHandler(target: self, handler: { [weak self] (target: MapViewController) -> (PoiInteractionEventParam) -> Void in
                                    return { param in
                                        guard let self = self else { return }
                                        print("🖱 마커 클릭됨: \(param.poiItem.itemID)")
                                        self.selectedStopName = param.poiItem.itemID
                                        self.showBusInfoView()
                                    }
                                })

                                poi.show()
                                print("🚌 마커 추가됨: \(markerTitle)")
                            }
                            layer.showAllPois()
                        }
                        
                    }
                }
                

            }
        }
    }


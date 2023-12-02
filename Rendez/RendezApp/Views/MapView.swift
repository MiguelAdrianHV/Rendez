//
//  MapView.swift
//  Rendez
//
//  Created by Miguel Hernandez on 5/30/23.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        let coordinate = CLLocationCoordinate2D(latitude: 20.130176, longitude: -115.2012655)
        
        let span = MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 20)
        
        let region = MKCoordinateRegion(center: coordinate, span: span)
        
        uiView.setRegion(region, animated: true)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}

import React, { useState, useRef } from 'react';
import useSwr from 'swr';
import GoogleMapReact from 'google-map-react';
import useSupercluster from 'use-supercluster';

import './Map.css';

const fetcher = (...args) => fetch(...args).then((response) => response.json());
const Marker = ({ children }) => children;

export default function SimpleMap() {
  const mapRef = useRef();
  const [bounds, setBounds] = useState(null);
  const [zoom, setZoom] = useState(10);

  const url = 'https://data.police.uk/api/crimes-street/all-crime?lat=52.629729&lng=-1.131592&date=2019-10';
  const { data, error } = useSwr(url, { fetcher });
  const crimes = data && !error ? data.slice(0, 2000) : [];
  const points = crimes.map((crime) => ({
    type: 'Feature',
    properties: { cluster: false, crimeId: crime.id, category: crime.category },
    geometry: {
      type: 'Point',
      coordinates: [
        parseFloat(crime.location.longitude),
        parseFloat(crime.location.latitude),
      ],
    },
  }));

  const { clusters, supercluster } = useSupercluster({
    points,
    bounds,
    zoom,
    options: { radius: 75, maxZoom: 20 },
  });

  return (
    <div style={{ height: '100vh', width: '100%' }}>
      <GoogleMapReact
        bootstrapURLKeys={{ key: 'AIzaSyDPud43hAXwyKatyGD_5iJon9xN5BDhpxo' }}
        defaultCenter={{ lat: 52.6376, lng: -1.135171 }}
        defaultZoom={3}
        yesIWantToUseGoogleMapApiInternals
        onGoogleApiLoaded={({ map }) => {
          mapRef.current = map;
        }}
        onChange={({ zoom, bounds }) => {
          setZoom(zoom);
          setBounds([
            bounds.nw.lng,
            bounds.se.lat,
            bounds.se.lng,
            bounds.nw.lat,
          ]);
        }}
      >
        {clusters.map((cluster) => {
          const [longitude, latitude] = cluster.geometry.coordinates;
          const {
            cluster: isCluster,
            point_count: pointCount,
          } = cluster.properties;

          if (isCluster) {
            return (
              <Marker
                key={`cluster-${cluster.id}`}
                lat={latitude}
                lng={longitude}
              >
                <div
                  className="cluster-marker"
                  style={{
                    width: `${10 + (pointCount / points.length) * 20}px`,
                    height: `${10 + (pointCount / points.length) * 20}px`,
                  }}
                  onClick={() => {
                    const expansionZoom = Math.min(
                      supercluster.getClusterExpansionZoom(cluster.id),
                      20,
                    );
                    mapRef.current.setZoom(expansionZoom);
                    mapRef.current.panTo({ lat: latitude, lng: longitude });
                  }}
                >
                  {pointCount}
                </div>
              </Marker>
            );
          }

          return (
            <Marker
              key={`crime-${cluster.properties.crimeId}`}
              lat={latitude}
              lng={longitude}
            >
              <button className="crime-marker">
                <img src="images/custody.svg" alt="crime doesn't pay" />
              </button>
            </Marker>
          );
        })}
      </GoogleMapReact>
    </div>
  );
}
// import React, { Component } from 'react';
// import GoogleMapReact from 'google-map-react';

// const AnyReactComponent = ({ text }) => <div>{text}</div>;

// class SimpleMap extends Component {
//   static defaultProps = {
//     center: {
//       lat: 0,
//       lng: 0,
//     },
//     zoom: 3,
//   };

//   render() {
//     return (
//       <div style={{ height: '100vh', width: '100%' }}>
//         <GoogleMapReact
//           bootstrapURLKeys={{ key: 'AIzaSyDPud43hAXwyKatyGD_5iJon9xN5BDhpxo' }}
//           defaultCenter={this.props.center}
//           defaultZoom={this.props.zoom}
//         >
//           <AnyReactComponent
//             lat={59.955413}
//             lng={30.337844}
//             text="My Marker"
//           />
//         </GoogleMapReact>
//       </div>
//     );
//   }
// }

// export default SimpleMap;

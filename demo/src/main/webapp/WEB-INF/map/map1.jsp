<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>카카오맵 카테고리 검색</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=56203df9ba6a9876af824b38ea2ec90f&libraries=services"></script>
    <style>
        #map { width: 100%; height: 500px; border: 1px solid #ccc; margin-top: 10px; }
    </style>
</head>
<body>
    <div id="app">
        <div>
            <select v-model="category">
                <option value="">:: 카테고리 선택 ::</option>
                <option value="MT1">대형마트</option>
                <option value="CS2">편의점</option>
                <option value="PS3">어린이집, 유치원</option>
                <option value="SC4">학교</option>
                <option value="AC5">학원</option>
                <option value="PK6">주차장</option>
                <option value="OL7">주유소, 충전소</option>
                <option value="SW8">지하철역</option>
                <option value="BK9">은행</option>
                <option value="CT1">문화시설</option>
                <option value="AG2">중개업소</option>
                <option value="PO3">공공기관</option>
                <option value="AT4">관광명소</option>
                <option value="AD5">숙박</option>
                <option value="FD6">음식점</option>
                <option value="CE7">카페</option>
                <option value="HP8">병원</option>
                <option value="PM9">약국</option>
            </select>
            <span> (선택된 카테고리: {{ category }})</span>
        </div>
        <hr>
        <div id="map"></div>
    </div>

    <script>
        const app = Vue.createApp({
            data() {
                return {
                    category: '', // 현재 선택된 카테고리 코드
                    infowindow: null,
                    map: null,
                    ps: null,
                    markers: [] // 생성된 마커들을 담을 배열 (삭제용)
                };
            },
            watch: {
                // category 변수가 변할 때마다 이 함수가 실행됨
                category(newVal) {
                    if (newVal !== '') {
                        this.searchPlaces(newVal);
                    } else {
                        this.removeMarkers(); // 선택 해제 시 마커 제거
                    }
                }
            },
            methods: {
                fnMapInit() {
                    this.infowindow = new kakao.maps.InfoWindow({ zIndex: 1 });
                    const mapContainer = document.getElementById('map');
                    const mapOption = {
                        center: new kakao.maps.LatLng(37.566826, 126.9786567),
                        level: 3
                    };

                    this.map = new kakao.maps.Map(mapContainer, mapOption);
                    this.ps = new kakao.maps.services.Places(this.map);
                    
                    // 초기값이 있을 경우 검색 실행 (현재는 빈값)
                    if(this.category) this.searchPlaces(this.category);
                },

                // 검색 실행 함수
                searchPlaces(categoryCode) {
                    // 기존 마커들 모두 삭제
                    this.removeMarkers();
                    
                    // 카테고리 검색 실행 (콜백 함수에 .bind(this)를 써야 methods 접근 가능)
                    this.ps.categorySearch(categoryCode, this.placesSearchCB.bind(this), { useMapBounds: true });
                },

                placesSearchCB(data, status, pagination) {
                    if (status === kakao.maps.services.Status.OK) {
                        for (let i = 0; i < data.length; i++) {
                            this.displayMarker(data[i]);
                        }
                    }
                },

                displayMarker(place) {
                    const marker = new kakao.maps.Marker({
                        map: this.map,
                        position: new kakao.maps.LatLng(place.y, place.x)
                    });

                    // 마커 관리 배열에 추가
                    this.markers.push(marker);

                    kakao.maps.event.addListener(marker, 'click', () => {
                        this.infowindow.setContent('<div style="padding:5px;font-size:12px;">' + place.place_name + '</div>');
                        this.infowindow.open(this.map, marker);
                    });
                },

                // 지도 위의 마커를 모두 제거하는 함수
                removeMarkers() {
                    for (let i = 0; i < this.markers.length; i++) {
                        this.markers[i].setMap(null);
                    }
                    this.markers = [];
                    this.infowindow.close();
                }
            },
            mounted() {
                this.fnMapInit();
            }
        });

        app.mount('#app');
    </script>
</body>
</html>
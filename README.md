

# 프로젝트 소개

# 스크린샷
<img src="https://github.com/Greeddk/WhattoWatch/assets/116425551/404c60f9-25f6-4d40-8251-4c0c604fc0d3"/>

# 앱 소개 & 기획
## ‎‎뭐볼까 - 인기 영화와 드라마의 정보를 한눈에 볼 수 있는 앱

## 개발 기간과 v1.0 버전 기능
### 개발 기간
- 2024.01.25 ~ 2024.02.10 (17일)
<br>

### Configuration
- 최소버전 16.0 / 다크 모드 / 세로 모드 / iOS전용
<br>

### v1.0 기능
1. 인기 드라마 / 영화 정보 제공
 - OTT 형태의 레이아웃 구현
 - 클릭 시 상세정보 페이지로 이동
 <br>
 
2. 드라마 검색 기능
 - 드라마 검색 및 상세 정보 제공
 - 추천 컨텐츠로 비슷한 컨텐츠 정보 제공
 <br>

### 기술 스택
- UIKit / MVC
- Alamofire / URLSession / GCD
- Kingfisher
- SnapKit
<br>
<br>

# ⚒️트러블 슈팅

## 1. 드라마의 정보를 받아와야지 드라마 로고 이미지를 받을 수 있는 문제

 <img src="https://github.com/Greeddk/WhattoWatch/assets/116425551/8335ca76-5a49-4a5c-8026-4341b737c881"/>

  TMDB API에서는 드라마/영화 id로 해당 컨텐츠의 로고 이미지 url을 얻을 수 있다. 하지만 id를 얻기 위해서는 기본적으로 인기 순위 API로 컨텐츠에 대한 정보를 받아와야 한다. 이 문제를 해결 하기 위해 DispatchGroup을 사용해 순차적으로 이미지를 받아올 수 있게 하였다.
 
<details>
<summary>코드 보기</summary>
  

```
private func callAPI() {
        
        let group = DispatchGroup()
        let imageGroup = DispatchGroup()
        
        group.enter()
        imageGroup.enter()
        apiManager.request(type: TVData.self, api: .tvTopRatedURL) { show in
            self.showList[0] = show.results
            group.leave()
            imageGroup.leave()
        }
        
        
        group.enter()
        imageGroup.notify(queue: .main) {
            self.showList[0].forEach {
                group.enter()
                let id = $0.id
                self.apiManager.request(type: ShowImage.self, api: .tvLogoURL(id: id)) { show in
                    self.showLogo[id] = show.logos.first?.logo
                    group.leave()
                }
            }
            group.leave()
        }
        
        group.enter()
        apiManager.request(type: TVData.self, api: .tvPopularURL) { show in
            self.showList[1] = show.results
            group.leave()
        }
        
        group.enter()
        apiManager.request(type: TVData.self, api: .tvTrendURL) { show in
            self.showList[2] = show.results
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.tableView.reloadData()
        }
        
    }

```
</details>
<br>

## 2. 커스텀 뷰 재 사용

 <img src="https://github.com/Greeddk/WhattoWatch/assets/116425551/24071525-00ab-4184-82d2-df4d6bdadf4a"/>

  영화 정보가 나오는 커스텀 뷰를 추천 컨텐츠에서도 사용하기 위해 방법을 고민하던 중 convenience init을 알게 되어 이를 활용해 뷰를 재활용 할 수 있었다.
  
<details>
<summary>코드 보기</summary>
  
```
enum MediaType {
    case TV
    case Movie
}

class MediaCardView: BaseView {
    
    var isMovie: Bool = false

    let releasedateLabel = UILabel()
    let genreLabel = UILabel()
    let backView = UIView()
    let backShadowView = UIView()
    let posterImageView = UIImageView()
    let rateTextLabel = UILabel()
    let rateLabel = UILabel()
    let titleLabel = UILabel()
    let descLabel = UILabel()
    let lineView = UIView()
    let moreLabel = UILabel()
    let moreButton = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(type: MediaType) {
        self.init(frame: .zero)
        isMovie = type == .Movie ? true : false
    }
    
    override func configureHierarchy() {
        addSubviews([releasedateLabel, genreLabel, backView, backShadowView])
        backView.addSubviews([posterImageView, rateTextLabel, rateLabel, titleLabel, descLabel, lineView, moreLabel, moreButton])
    }
    
    override func layoutSubviews() {
        if isMovie {
            releasedateLabel.snp.makeConstraints { make in
                make.top.equalTo(self).offset(8)
                make.horizontalEdges.equalTo(self).inset(8)
                make.height.equalTo(20)
            }
            
            genreLabel.snp.makeConstraints { make in
                make.top.equalTo(releasedateLabel.snp.bottom)
                make.horizontalEdges.equalTo(self).inset(8)
                make.height.equalTo(20)
            }
            
            backView.snp.makeConstraints { make in
                make.top.equalTo(genreLabel.snp.bottom).offset(4)
                make.horizontalEdges.equalTo(self).inset(8)
                make.bottom.greaterThanOrEqualTo(self.safeAreaLayoutGuide).offset(-12)
            }
        } else {
            backView.snp.makeConstraints { make in
                make.top.equalTo(self).offset(4)
                make.horizontalEdges.equalTo(self).inset(8)
                make.bottom.greaterThanOrEqualTo(self).offset(-12)
            }
        }
  
        //나머지 뷰객체 레이아웃
    }
    
    override func configureView() {
        // 뷰객체 설정들
    }
    
    func configureCell(item: TVShow) {
        let url = TMDBAPI.imageURL(imageURL: item.backdrop_path ?? "").endpoint
        posterImageView.kf.setImage(with: url)
        rateLabel.text = String(format: "%.1f", item.vote_average)
        titleLabel.text = item.name
        descLabel.text = item.overview
    }
    
    func configureCell(item: Movie) {
        releasedateLabel.text = changeDateFormat(text: item.release_date)
        let genre = Genre.genreList.filter { $0.id == item.genre_ids[0] }
        genreLabel.text = "#\(genre[0].name)"

        let url = TMDBAPI.imageURL(imageURL: item.backdrop_path ?? "").endpoint
        posterImageView.kf.setImage(with: url)
        
        rateLabel.text = String(format: "%.1f", item.vote_average)
        
        titleLabel.text = item.title
        descLabel.text = item.overview
    }
    
    private func changeDateFormat(text: String) -> String {
        
        let originFormatter = DateFormatter()
        originFormatter.dateFormat = "yyyy-MM-dd"
        guard let origin = originFormatter.date(from: text) else {
            return "정보 없음"
        }
        
        let targetFormatter = DateFormatter()
        targetFormatter.dateFormat = "yyyy/MM/dd"
        let result = targetFormatter.string(from: origin )
        
        return result
    }
    
}
```
</details>
<br>

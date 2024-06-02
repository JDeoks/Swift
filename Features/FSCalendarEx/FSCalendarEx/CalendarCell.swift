import Foundation
import FSCalendar
import SnapKit

class CalendarCell: FSCalendarCell {
    
    // 뒤에 표시될 이미지
    var backImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    var selectIndicator = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    // 셀의 높이와 너비 중 작은 값을 리턴한다
    var minSize: CGFloat {
        let width = contentView.bounds.width
        let height = contentView.bounds.height - titleLabel.intrinsicContentSize.height - 9
        return (width > height) ? height : width
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // contentView
        contentView.backgroundColor = .clear
//        print("contentView 사이즈:", contentView.frame)
        
        // backImageView
        contentView.insertSubview(backImageView, at: 0)
        backImageView.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.size.equalTo(minSize)
            make.top.equalTo(contentView).offset(2)
        }
        backImageView.layer.cornerRadius = minSize / 2
        backImageView.backgroundColor = .systemGray5
        
        // titleLabel
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(backImageView.snp.bottom).offset(4)
            make.centerX.equalTo(contentView)
            make.bottom.equalTo(contentView).offset(-5)

        }
        
        // selectIndicator
        contentView.addSubview(selectIndicator)
        selectIndicator.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.bottom.equalTo(contentView).offset(-3)
            make.width.equalTo(18)
            make.height.equalTo(1)
        }
        
    }

    
    required init!(coder aDecoder: NSCoder!) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // titleLabel 폰트 설정
        titleLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        titleLabel.sizeToFit()  // 크기를 내용에 맞게 조정

        // backImageView 크기 및 코너 반경 설정
        backImageView.snp.updateConstraints { make in
            make.size.equalTo(minSize)
        }
        backImageView.layer.cornerRadius = minSize / 2
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        backImageView.image = nil
        selectIndicator.alpha = 0
    }


    
}

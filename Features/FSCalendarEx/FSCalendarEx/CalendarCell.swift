import Foundation
import FSCalendar
import SnapKit

class CalendarCell: FSCalendarCell {
    private let topInset: CGFloat = 8
    private let bottomInset: CGFloat = 4
    private let imageSize: CGFloat = 36
    
    // 뒤에 표시될 이미지
    var backImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    var selectIndicator: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initUI()
    }
    
    private func initUI() {
        // contentView
        contentView.backgroundColor = .clear
        
        // backImageView
        contentView.insertSubview(backImageView, at: 0)
        backImageView.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.size.equalTo(imageSize)
            make.top.equalTo(contentView).offset(topInset)
        }
        backImageView.layer.cornerRadius = imageSize / 2
        backImageView.backgroundColor = .systemGray5
        
        // titleLabel (숨기기)
        titleLabel.isHidden = true
        
        // dateLabel
        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.bottom.equalTo(contentView).offset(-bottomInset - 2)
        }
        
        // selectIndicator
        contentView.addSubview(selectIndicator)
        selectIndicator.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.bottom.equalTo(contentView).offset(-bottomInset)
            make.width.equalTo(18)
            make.height.equalTo(1)
        }
    }

    required init!(coder aDecoder: NSCoder!) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        backImageView.image = nil
    }
}

//
//  ViewController.swift
//  UIDatePicker
//
//  Created by 서정덕 on 11/18/23.
//

import UIKit

class ViewController: UIViewController {

    private let datePicker = UIDatePicker()
    private let selectedDateLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    // MARK: - UI
    private func configureUI() {
        setAttributes()
        setConstraints()
    }

    private func setAttributes() {
        datePicker.preferredDatePickerStyle = .automatic
        datePicker.datePickerMode = .dateAndTime
        datePicker.locale = Locale(identifier: "ko-KR")
        datePicker.timeZone = .autoupdatingCurrent
//        datePicker.tintColor = .brown
//        datePicker.backgroundColor = .darkGray
        datePicker.addTarget(self, action: #selector(handleDatePicker(_:)), for: .valueChanged)
        datePicker.setValue(UIColor.red, forKeyPath: "textColor")
        datePicker.setValue(false, forKeyPath: "highlightsToday")
        view.addSubview(selectedDateLabel)
    }

    private func setConstraints() {
        view.addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        selectedDateLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            datePicker.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            selectedDateLabel.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 10),
            selectedDateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }

    // MARK: - Selectors
    @objc
    private func handleDatePicker(_ sender: UIDatePicker) {
        print(sender.date)
        updateSelectedDateLabel(date: sender.date)
    }

    private func updateSelectedDateLabel(date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        selectedDateLabel.text = "Selected Date: \(dateFormatter.string(from: date))"
    }
}



//
//  ViewController.swift
//  calendar
//
//  Created by Fernando Mota e Silva on 22/10/17.
//  Copyright © 2017 HalphDem. All rights reserved.
///Users/fernando/Desktop/calendar/calendar/CustomCellCollectionViewCell.swift

import UIKit
import JTAppleCalendar

class ViewController: UIViewController {
    
    let formatter = DateFormatter()
    
    @IBOutlet weak var calenarView: JTAppleCalendarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calenarView.register(UINib(nibName: "CalendarHeader", bundle: nil), forSupplementaryViewOfKind: "UICollectionElementKindSectionHeader", withReuseIdentifier: "CalendarHeader")
        
        
    }
}

extension ViewController: JTAppleCalendarViewDelegate, JTAppleCalendarViewDataSource {
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        
        let startDate = formatter.date(from: "2017-01-01")!
        let endDate = formatter.date(from: "2017-12-31")!
        
        
        let parameters = ConfigurationParameters(startDate: startDate, endDate: endDate)
        return parameters
    }
    
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCell
        
        cell.dateLabel.text = cellState.text
        
        if cellState.dateBelongsTo != .thisMonth {
            cell.dateLabel.textColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.3)
        } else {
            cell.dateLabel.textColor = UIColor.black
        }
        
        return cell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, headerViewForDateRange range: (start: Date, end: Date), at indexPath: IndexPath) -> JTAppleCollectionReusableView {
        let calendarHeader = calendar.dequeueReusableJTAppleSupplementaryView(withReuseIdentifier: "CalendarHeader", for: indexPath) as! CalendarHeader
        
        formatter.dateFormat = "MMMM"
        calendarHeader.title.text = formatter.string(from: range.start)
        
        return calendarHeader
    }
    
    func calendarSizeForMonths(_ calendar: JTAppleCalendarView?) -> MonthSize? {
        return MonthSize(defaultSize: 100)
    }
}


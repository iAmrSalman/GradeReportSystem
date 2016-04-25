//
//  Quiz.swift
//  GradeReportSystem
//
//  Created by Amr Salman on 4/24/16.
//  Copyright © 2016 Amr Salman. All rights reserved.
//

import Foundation

class Quiz {
    private var _quizNumber: Int
    private var _quizDate: String
    private var _quizGrade: Double
    
    var quizNumber: Int {
        return _quizNumber
    }
    
    var quizDate: String {
        return _quizDate
    }
    
    var quizGrade: Double {
        return _quizGrade
    }
    
    var quizJSON: [String:AnyObject] {
        return ["quiz-data" : quizDate, "quiz-grade" : quizGrade]
    }
    
    init(quizDate: String, quizGrade: Double, quizNumber: Int) {
        _quizDate = quizDate
        _quizNumber = quizNumber
        _quizGrade = quizGrade
    }
}
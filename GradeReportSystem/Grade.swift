//
//  Grade.swift
//  GradeReportSystem
//
//  Created by Amr Salman on 4/24/16.
//  Copyright © 2016 Amr Salman. All rights reserved.
//

import Foundation

class Grade {
    private var _finalGrade: Double
    private var _midtermGrade: Double
    private var _quizGrade: Double
    
    var quizGrade: Double {
        return _quizGrade
    }

    var finalGrade: Double {
        return _finalGrade
    }
    
    var midtermGrade: Double {
        return _midtermGrade
    }
    
    
    var gradJSON: [String:AnyObject] {
        return ["final-grade" : finalGrade, "midterm-grade" : midtermGrade, "quiz-grade" : quizGrade]
    }
    
    init(finalGrade: Double, midtermGrade: Double, quizGrade: Double) {
        _finalGrade = finalGrade
        _midtermGrade = midtermGrade
        _quizGrade = quizGrade
    }
	
	init(dictionadry: Dictionary<String, AnyObject>) {
		if let finalGrade = dictionadry["final-grade"] as? Double {
			_finalGrade = finalGrade
		} else {
			_finalGrade = 0.0
		}
		
        if let midtermGrade = dictionadry["midterm-grade"] as? Double {
            _midtermGrade = midtermGrade
        } else {
            _midtermGrade = 0.0
        }
        
        if let quizGrade = dictionadry["quiz-grade"] as? Double {
            _quizGrade = quizGrade
        } else {
            _quizGrade = 0.0
        }
	}
}
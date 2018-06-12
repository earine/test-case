//
//  Dinner.swift
//  test2
//
//  Created by Marina Lunts on 11.06.2018.
//  Copyright © 2018 Marina Lunts. All rights reserved.
//

import UIKit

class Dinner: NSObject {
    private var salad: Dictionary<Int, Any>?
    private var soup: Dictionary<Int, Any>?
    private var entree: Dictionary<Int, Any>?
    private let garnish = [10: "Рис отварной", 11: "Картофельное пюре", 12: "Каша гречневая"]
    
    
    public func weekdayDish() {
        switch Date().dayNumberOfWeek() {
        case 1:
            self.salad = [1: "Салат из свежих овощей", 2: "Салат из свежей капусты", 3: "Овощи микс"]
            self.soup =  [4: "Овощной бульон", 5: "Бульон из домашней курицы", 6: "Солянка"]
            self.entree = [7: "Отварная куриная грудинка", 8: "Куриная отбивная", 9: "Рыба на пару"]
        case 2:
            self.salad = [1: "Салат из свежих овощей", 2: "Салат из свежей капусты и зеленью", 3: "Овощи микс отварные"]
            self.soup =  [4: "Овощной бульон", 5: "Бульон из домашней курицы", 6: "Солянка"]
            self.entree = [7: "Отварная куриная грудинка", 8: "Куриная отбивная", 9: "Рыба на пару"]
        case 3:
            self.salad = [1: "Салат из свежих овощей с маслом", 2: "Салат из свежей капусты и зеленью", 3: "Овощи микс отварные"]
            self.soup =  [4: "Суп сырный", 5: "Овощной бульон", 6: "Солянка"]
            self.entree = [7: "Курина отбивная", 8: "Рыба на пару", 9: "Цветная капуста отварная"]
        case 4:
            self.salad = [1: "Салат из свежих овощей", 2: "Салат из свежей капусты и зелени", 3: "Салат из свежих овощей с бранзой"]
            self.soup =  [4: "Борщ красный", 5: "Бульон из домашней курицы", 6: "Солянка"]
            self.entree = [7: "Отварная куриная грудинка", 8: "Рыба на пару с овощами", 9: "Картофель молодой с укропом"]
        case 5:
            self.salad = [1: "Салат из свежих овощей", 2: "Салат из квашеной капусты", 3: "Овощи микс отварные"]
            self.soup =  [4: "Бульон куриный с рисом", 5: "Овощной бульон", 6: "Грибной крем-суп"]
              self.entree = [7: "Курина отбивная", 8: "Рыбные тефтели паровые", 9: "Куриное филе гриль с картофельным пюре"]
        default:
            self.salad = [1: "Салат из свежих овощей", 2: "Салат из свежей капусты", 3: "Овощи микс"]
            self.soup =  [4: "Овощной бульон", 5: "Бульон из домашней курицы", 6: "Солянка"]
        }
    }
    
    
    public func getDinner(row: [String], type: String) -> String {
        switch type {
        case "salad":
            for index in 1...3 {
                if !(row[index]).isEmpty {
                    return "\(salad![index] ?? "Cалат")"
                }
            }
        case "soup":
            for index in 4...6 {
                if !(row[index]).isEmpty {
                    return "\(soup![index] ?? "Суп")"
                }
            }
            
        case "entree":
            for index in 7...9 {
                if !(row[index]).isEmpty {
                    return "\(entree![index] ?? "Основное блюдо")"
                }
            }
        case "garnish":
            for index in 10...12 {
                if !(row[index]).isEmpty {
                    return "\(garnish[index] ?? "Гарнир")"
                }
            } 
        default:
            return "На сегодня блюдо не выбрано :("
        }
        
        
        return "На сегодня блюдо не выбрано :("
    }
    
    
    
}

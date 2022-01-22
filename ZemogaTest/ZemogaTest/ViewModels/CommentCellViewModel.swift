//
//  CommentCellViewModel.swift
//  ZemogaTest
//
//  Created by Jhonnatan Macias on 21/01/22.
//

import Foundation

protocol CommentCellViewModelProtocol: AnyObject {
    
    // MARK: - Properties

    var comment: Bindable<String> { get }
    
}

class CommentCellViewModel: CommentCellViewModelProtocol {
    
    var comment: Bindable<String> = Bindable("")
    
    init(comment: String) {
        self.comment.value = comment
    }
    
    
}

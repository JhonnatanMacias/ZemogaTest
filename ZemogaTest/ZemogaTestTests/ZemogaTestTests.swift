//
//  ZemogaTestTests.swift
//  ZemogaTestTests
//
//  Created by Jhonnatan Macias on 18/01/22.
//

import XCTest
@testable import ZemogaTest

class ZemogaTestTests: XCTestCase {
    
    var viewModel: PostsViewModel!
    var viewController: PostsViewController!
    var modelMock: [Post]!
    
    override func setUpWithError() throws {
        viewModel =  PostsViewModel()
        viewController = PostsViewController()
        modelMock = FakePostModel().model
    }

    override func tearDownWithError() throws {
        viewModel = nil
        viewController = nil
        modelMock = nil
    }
    
    func testInit() {
        viewModel.postModel.value = modelMock
        let postMessage = "1 Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s"

        XCTAssertEqual(viewModel.postModel.value.count, 6, "model count bindable value doesn't match expected initial value")
        XCTAssertEqual(viewModel.postModel.value[5].postDetail.isFavorited, true)
        XCTAssertNotNil(viewModel.postModel.value)
        XCTAssertEqual(viewModel.postModel.value.first?.id, 0, "Id bindable value doesn't match expected initial value")
        XCTAssertEqual(viewModel.postModel.value.first?.message, postMessage, "message bindable value doesn't match expected initial value")
        XCTAssertEqual(viewModel.postModel.value.first?.postDetail.comments.count, 3, "amount of comments  bindable value doesn't match expected initial value")
    }
    
    func testDataLoadSuccessfully() {
        
        // setting up expectations
        let startedLoadingExpectation = expectation(description: "got callback start loading")
        let mockRepository = MockPostsServices()
        mockRepository.model = FakePostModel().model
        viewModel.repository = mockRepository
        
        viewModel.repository.getPostFromService { result in
            switch result {
            case .success(let posts):
                XCTAssertNotNil(posts)
                XCTAssertEqual(posts.count, 6, "model count value doesn't match expected initial value")
            case .failure(let error):
                XCTAssertNil(error)
            }
            startedLoadingExpectation.fulfill()
        }
    
        
        viewModel.getPosts()
        
//         check for expectation
        wait(for: [
            startedLoadingExpectation
        ], timeout: 1, enforceOrder: true)
    }
    
    /// Loading games list ends with error
    func testDataLoadedWithError() {
            
        // setting up expectation
        let errorOccuredExpectation = expectation(description: "loading error expectation.")
        
        let mockRepository = MockPostsServices()
        mockRepository.error = NSError(domain: "", code: 500, userInfo: [NSLocalizedDescriptionKey : "Object does not exist"])
        mockRepository.model = nil
        
        viewModel.repository = mockRepository
        
        viewModel.repository.getPostFromService { result in
            switch result {
            case .success(let posts):
                XCTAssertNil(posts)
                
            case .failure(let error):
                XCTAssertNotNil(error)
                XCTAssertEqual(error.localizedDescription, "Object does not exist")
                errorOccuredExpectation.fulfill()
            }
            
        }
        
        viewModel.getPosts()
        
//         check for expectation
        wait(for: [
            errorOccuredExpectation
        ], timeout: 1, enforceOrder: true)
    }
    

}

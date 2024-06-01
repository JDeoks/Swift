//
//  TodoListViewModel.swift
//  voiceMemo
//

import Foundation

class TodoListViewModel: ObservableObject {
    
    // 투두 리스트
    @Published var todos: [Todo]
    // 투두 편집모드 여부
    @Published var isEditTodoMode: Bool
    // 삭제모드에서 선택한 투두 목록
    @Published var removeTodos: [Todo]
    // alert 표시 여부
    @Published var isDisplayRemoveRodoAlert: Bool
    
    // 삭제할 투두 개수
    var removeTodosCount: Int {
        return removeTodos.count
    }
    
    var navigationBarRightBtnMode: NavigationBtnType {
        isEditTodoMode ? .complete : .edit
    }
    
    init(
        todos: [Todo] = [],
        isEditModeTodoMode: Bool = false,
        removeTodos: [Todo] = [],
        isDisplayRemoveRodoAlert: Bool = false) {
        self.todos = todos
        self.isEditTodoMode = isEditModeTodoMode
        self.removeTodos = removeTodos
        self.isDisplayRemoveRodoAlert = isDisplayRemoveRodoAlert
    }
  
}

extension TodoListViewModel {
    
    func selectedBoxTapped(_ todo: Todo) {
        if let index = todos.firstIndex(where: {$0 == todo}) {
            todos[index].selected.toggle()
        }
    }
    
    func addTodo(_ todo: Todo) {
        todos.append(todo)
    }
    
    func navigationRightBtnTapped() {
        if isEditTodoMode {
            if removeTodos.isEmpty {
                isEditTodoMode = false
            } else {
                setIsDisplayRemoveRodoAlert(isDisplay: true)
            }
        } else {
            isEditTodoMode = true
        }
    }
    
    func setIsDisplayRemoveRodoAlert(isDisplay: Bool) {
        isDisplayRemoveRodoAlert = isDisplay
    }
    
    func todoRemoveSelectedBoxTapped(todo: Todo) {
        if let index = removeTodos.firstIndex(of: todo) {
            removeTodos.remove(at: index)
        } else {
            removeTodos.append(todo)
        }
    }
    
    func removeBtnTapped() {
        // removeTodos에 있는 요소를 todos에서 삭제
        todos.removeAll { todo in
            removeTodos.contains(todo)
        }
        removeTodos.removeAll()
        isEditTodoMode = false
    }
}

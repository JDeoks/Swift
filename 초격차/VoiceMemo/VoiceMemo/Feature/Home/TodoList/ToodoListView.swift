//
//  ToodoListView.swift
//  voiceMemo
//

import SwiftUI

struct TodoListView: View {
    @EnvironmentObject private var pathModel: PathModel
    @EnvironmentObject private var todoListViewModel: TodoListViewModel
    
    var body: some View {
        ZStack {
            // 투두 셀 리스트
            VStack {
                // 네비게이션 바
                if !todoListViewModel.todos.isEmpty {
                    CustomNavigationBar(
                        isDisplayLeftBtn: false,
                        rightBtnAction: {
                            todoListViewModel.navigationRightBtnTapped()
                        },
                        rightBtnType: todoListViewModel.navigationBarRightBtnMode
                    )
                } else {
                    Spacer()
                        .frame(height: 30)
                }
                
                TitleView()
                    .padding(.top, 20)
                
                if todoListViewModel.todos.isEmpty {
                    AnnouncementView()
                        .padding(.top, 20)
                } else {
                    TodoListContentView()
                        .padding(.top, 20)
                }
                
            }
            
            WriteTodoBtnView()
                .padding(.bottom, 50)
                .padding(.trailing, 20)
            
        }
        .alert("투두를 삭제할까요?",
               isPresented: $todoListViewModel.isDisplayRemoveRodoAlert
        ) {
            Button("삭제", role: .destructive) {
                todoListViewModel.removeBtnTapped()
            }
            
            Button("취소", role: .cancel) { }
        }
    }
    

}

// MARK: - 투두 타이틀
fileprivate struct TitleView: View {
    @EnvironmentObject private var todoListViewModel: TodoListViewModel
    
    var body: some View {
        HStack {
            if todoListViewModel.todos.isEmpty {
                Text("To do list를\n추가해 보세요.")
            } else {
                Text("To do list \(todoListViewModel.todos.count)개가\n있습니다.")
            }
            Spacer()
        }
        .font(.system(size: 30, weight: .bold))
        .padding(.leading, 20)
    }
}

// MARK: - 투두리스트 안내뷰
fileprivate struct AnnouncementView: View {
    var body: some View {
        VStack(spacing: 15) {
            Spacer()
            
            Image("pencil")
                .renderingMode(.template)
            
            Text("\"매일아침 5시에 운동하자!\"")
            Text("\"내일 8시 수강 신청하자!\"")
            Text("\"1시 반 점심약속 리마인드 해보자\"")
            
            Spacer()
        }
        .font(.system(size: 16))
        .foregroundStyle(Color.customGray2)
    }
}

// MARK: - 투두 리스트 컨텐츠 뷰
fileprivate struct TodoListContentView: View {
    @EnvironmentObject private var todoListViewModel: TodoListViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text("할일 목록")
                    .font(.system(size: 16, weight: .bold))
                    .padding(.leading, 20)
                
                Spacer()
            }
            
            ScrollView(.vertical) {
                VStack(spacing: 0) {
                    Rectangle()
                        .fill(Color.customGray0)
                        .frame(height: 1)
                    
                    ForEach(todoListViewModel.todos, id: \.self) { todo in
                        TodoCellView(todo: todo)
                    }
                }
            }
        }
    }
}

fileprivate struct TodoCellView: View {
    @EnvironmentObject private var todoListViewModel: TodoListViewModel
    @State private var isRemoveSelected: Bool
    private var todo: Todo
    
    fileprivate init(
        isRemoveSelected: Bool  = false,
        todo: Todo
    ) {
        _isRemoveSelected = State(initialValue: isRemoveSelected)
        self.todo = todo
    }
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                if !todoListViewModel.isEditTodoMode {
                    Button  {
                        todoListViewModel.selectedBoxTapped(todo)
                    } label: {
                        todo.selected ? Image("selectedBox") : Image("unSelectedBox")
                    }
                }
                
                VStack(alignment: .leading, spacing: 5){
                    Text(todo.title)
                        .font(.system(size: 16))
                        .foregroundStyle(todo.selected ? Color.customIconGray : Color.customBlack)
                    Text(todo.convertedDayAndtime)
                        .font(.system(size: 16))
                        .foregroundStyle(Color.customIconGray)
                        .strikethrough(todo.selected)
                }
                
                Spacer()
                
                if todoListViewModel.isEditTodoMode {
                    Button {
                        isRemoveSelected.toggle()
                        todoListViewModel.todoRemoveSelectedBoxTapped(todo: todo)
                    } label: {
                        isRemoveSelected ? Image("selectedBox") : Image("unSelectedBox")
                    }

                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)
            
            Rectangle()
                .fill(Color.customGray0)
                .frame(height: 1)
        }
        
    }
}

// MARK: - 투두 작성 플로트 버튼

fileprivate struct WriteTodoBtnView: View {
    @EnvironmentObject private var pathModel: PathModel
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Spacer()
                
                Button {
                    pathModel.paths.append(.todoView)
                } label: {
                    Image("writeBtn")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 72, height: 72)
                }

            }
        }
    
    }
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView()
            .environmentObject(PathModel())
            .environmentObject(TodoListViewModel(todos: [Todo(title: "d3s", time: Date(), day: Date(), selected: false), Todo(title: "ds", time: Date(), day: Date(), selected: false)]))
    }
}

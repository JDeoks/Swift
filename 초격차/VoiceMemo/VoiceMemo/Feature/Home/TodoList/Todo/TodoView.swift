//
//  TodoView.swift
//  voiceMemo
//

import SwiftUI

struct TodoView: View {
    @EnvironmentObject private var pathModel: PathModel
    @EnvironmentObject private var todoListViewModel: TodoListViewModel
    @StateObject private var todoViewModel = TodoViewModel()
    
    var body: some View {
        VStack {
            CustomNavigationBar(leftBtnAction: {
                pathModel.paths.removeLast()
            }, rightBtnAction: {
                todoListViewModel.addTodo(
                    .init(
                        title: todoViewModel.title,
                        time: todoViewModel.time,
                        day: todoViewModel.day,
                        selected: false
                    )
                )
                pathModel.paths.removeLast()
            },
            rightBtnType: .create
            )
            
            // 타이틀 뷰
            TitleView()
                .padding(.top, 20)
                
            Spacer()
                .frame(height: 20)
            
            // 투두 타이틀 뷰(텍스트필드)
            TodoTitleView(todoViewModel: todoViewModel)
                .padding(.leading, 20)
            
            // 시간 선택
            SelectTimeView(todoViewModel: todoViewModel)
            
            // 날짜 선택
            SelectDayView(todoViewModel: todoViewModel)
                .padding(.leading, 20)
        }
    }
}

fileprivate struct TitleView: View {
    var body: some View {
        HStack {
            Text("To do list를\n추가해 보세요.")
            
            Spacer()
        }
        .font(.system(size: 30, weight: .bold))
        .padding(.leading, 20)
    }
}

fileprivate struct TodoTitleView: View {
    @ObservedObject private var todoViewModel: TodoViewModel
    
    fileprivate init(todoViewModel: TodoViewModel) {
        self.todoViewModel = todoViewModel
    }
    
    var body: some View {
        TextField("제목을 입력하세요", text: $todoViewModel.title)
    }
}

fileprivate struct SelectTimeView: View {
    @ObservedObject private var todoViewModel: TodoViewModel

    fileprivate init(todoViewModel: TodoViewModel) {
        self.todoViewModel = todoViewModel
    }
    
    var body: some View {
        VStack {
            Rectangle()
                .fill(Color.customGray0)
                .frame(height: 1)
            
            DatePicker(
                "",
                selection: $todoViewModel.time,
                displayedComponents: [.hourAndMinute]
            )
            .labelsHidden()
            .datePickerStyle(.wheel)
            .frame(maxWidth: .infinity, alignment: .center)
            
            Rectangle()
                .fill(Color.customGray0)
                .frame(height: 1)
        }
    }
}

fileprivate struct SelectDayView: View {
    @ObservedObject private var todoViewModel: TodoViewModel

    fileprivate init(
        todoViewModel: TodoViewModel
    ) {
        self.todoViewModel = todoViewModel
    }
    
    var body: some View {
        VStack(spacing: 5){
            HStack {
                Text("날짜")
                    .foregroundStyle(Color.customIconGray)
                Spacer()
            }
            HStack {
                Button {
                    todoViewModel.setIsDisplayCalander(isDisplay: true)
                } label: {
                    Text("\(todoViewModel.day.formattedDay)")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundStyle(Color.customGreen)
                }
            }
            .popover(isPresented: $todoViewModel.isDisplayCalander, content: {
                DatePicker(
                    "",
                    selection: $todoViewModel.day,
                    displayedComponents: .date
                )
                .labelsHidden()
                .datePickerStyle(GraphicalDatePickerStyle())
                .frame(maxWidth: .infinity, alignment: .center)
                .padding()
                .onChange(of: todoViewModel.day) { _ in
                    todoViewModel.setIsDisplayCalander(isDisplay: false)
                }
                
            })
            Spacer()
        }
    }
}

struct TodoView_Previews: PreviewProvider {
  static var previews: some View {
    TodoView()
  }
}

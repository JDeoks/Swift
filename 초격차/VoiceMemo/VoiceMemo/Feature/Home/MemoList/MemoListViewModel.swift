//
//  MemoListViewModel.swift
//  voiceMemo
//

import Foundation

class MemoListViewModel: ObservableObject {
    @Published var memos: [Memo]
    @Published var isEditMemoMode: Bool
    @Published var removeMemos: [Memo]
    @Published var isDisplayRemoveMemoAlert: Bool = false
    
    var removeMemoCount: Int {
        return removeMemos.count
    }
    var navigationBarRightBtnMode: NavigationBtnType {
        isEditMemoMode ? .complete : .edit
    }
    
    init(
        memos: [Memo] = [],
        isEditMemoMode: Bool = false,
        removeMemos: [Memo] = [],
        isDisplayRemoveMemoAlert: Bool = false
    ) {
        self.memos = memos
        self.isEditMemoMode = isEditMemoMode
        self.removeMemos = removeMemos
        self.isDisplayRemoveMemoAlert = isDisplayRemoveMemoAlert
    }
    
}

extension MemoListViewModel {
    func addMemo(memo: Memo) {
        memos.append(memo)
    }
    
    func updateMemo(memo: Memo) {
        if let index = memos.firstIndex(where: {$0.id == memo.id}) {
            memos[index] = memo
        }
    }
    
    func removeMemo(memo: Memo) {
        if let index = memos.firstIndex(where: { $0.id == memo.id }) {
            memos.remove(at: index)
        }
    }
    
    func navigationRightBtnTapped() {
        // 삭제할 항목이 없으면 그대로 종료, 있으면 삭제 alert 띄움
        if isEditMemoMode {
            if removeMemos.isEmpty {
                isEditMemoMode = false
            } else {
                setIsDisplayRemoveMemoAlert(isDisplay: true)
            }
        } else {
            // 편집 모드로 변경
            isEditMemoMode = true
        }
    }
    
    func setIsDisplayRemoveMemoAlert(isDisplay: Bool) {
        isDisplayRemoveMemoAlert = isDisplay
    }
    
    /// 선택한 요소가 이미 있을 경우 삭제, 아닐 경우 추가
    func memoRemoveSelectedBoxTapped(memo: Memo) {
        if let index = removeMemos.firstIndex(of: memo) {
            removeMemos.remove(at: index)
        } else {
            removeMemos.append(memo)
        }
    }
    
    func removeBtnTapped() {
        memos.removeAll { memo in
            removeMemos.contains(memo)
        }
        removeMemos.removeAll()
        isEditMemoMode = false
    }
}

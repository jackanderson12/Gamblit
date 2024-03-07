//
//  TableTalkCellView.swift
//  Gamblit
//
//  Created by Jack Anderson on 3/7/24.
//

import SwiftUI

struct TableTalkCellView: View {
    
    @Binding var tableTalk: TableTalk
    
    var body: some View {
        VStack {
            Text(tableTalk.content)
        }
    }
}

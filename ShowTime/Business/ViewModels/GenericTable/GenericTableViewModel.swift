//
//  GenericTableViewModel.swift
//  ShowTime
//
//  Created by Miguel Solans on 22/10/2022.
//

import Foundation

protocol GenericTableViewModelDelegate {
    func genericTableOutputDidChange(_ viewModel: GenericTableViewModel);
}

class GenericTableViewModel {
    
    let model = GenericTableModel();
    var delegate: GenericTableViewModelDelegate?;
    
    func getGenericTable(_ table: String) {
        self.model.getOne(tableName: table) { output in
            self.genericTableOutput = output;
        } failure: { error in
            // TODO: Handle error
        }

    }
    
    func getItemByIndex(_ index: Int) -> GenericTableItem? {
        self.genericTableOutput?.data[index];
    }
    
    
    func convertOptionsToPicker() -> [DataPickerOption] {
        var options: [DataPickerOption] = [];
        
        if let safeOptions = self.genericTableOutput?.data {
            for option in safeOptions {
                let option = DataPickerOption(id: option.id, label: option.label);
                options.append(option)
            }
        }
        
        return options;
    }
    
    var genericTableOutput: GenericTableOutput? {
        didSet {
            self.delegate?.genericTableOutputDidChange(self);
        }
    }
    
}

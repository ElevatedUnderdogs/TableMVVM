# TableMVVM

Example: 

```swift
import UIKit
import TableMVVM

class ViewController: UIViewController {

    @IBOutlet var container: UIView!

    typealias MyDataSource = TableDataSource1<SectionNoHeader<ViewModelCell<ColorView>>>

    var table: TableMVVM<MyDataSource> = TableMVVM(
        viewModel: .init(
            section0: .init(
                cellsViewModels: [.red, .orange, .yellow, .green, .blue, .purple]
            )
        )
    )

    override func viewDidLoad() {
        super.viewDidLoad()
        container.inject(view: table)
    }
}

```

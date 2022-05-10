# TableMVVM

<img width="161" alt="Screen Shot 2021-09-22 at 9 32 46 AM" src="https://user-images.githubusercontent.com/4231144/134384591-8f5181e7-9b73-41c5-92cb-387243a1eae2.png">


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

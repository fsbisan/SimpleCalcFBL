//
//  ViewController.swift
//  SimpleCalcFBL
//
//  Created by Александр Макаров on 05.09.2022.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Views
    private let display = UITextField()
    private let displayView = UIView()
    private let mainVStack = UIView()
    
    //MARK: - Properties
    
    var calcService: CalcService?

    //MARK: - ViewControllers lifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calcService = CalcService(displayView: self)
        view.backgroundColor = AppColors.background
        configureAppearance()
    }
    
    //MARK: - ViewControllers methods
    
    func updateDisplay(text: String) {
        DispatchQueue.main.async {
            self.display.text = text
        }
    }
    @objc func buttonPressed(_ sender: UIButton) {
        switch sender.tag {
        case 0...9:
            calcService?.numberAction(number: sender.tag)
        case 10:
            calcService?.dot()
        case 11:
            calcService?.makeResult()
        case 12:
            calcService?.addition()
        case 13:
            calcService?.subtraction()
        case 14:
            calcService?.multiplication()
        case 15:
            calcService?.acAction()
        case 16:
            calcService?.changeSign()
        case 17:
            calcService?.percent()
        case 18:
            calcService?.division()
        default:
            break
        }
    }
}

//MARK: - ViewController private methods

private extension ViewController {
    func configureAppearance() {
        setupDisplayView()
        setupButtons()
        setupMainVStack()
    }
    
    func setupMainVStack() {
        mainVStack.frame = CGRect(x: 0, y: 60, width: Constants.screenWidth, height: Constants.screenHeight - 60)
       
        self.view.addSubview(mainVStack)
    }
    
    func setupDisplayView() {
        displayView.frame = CGRect(x: 0, y: 0, width: Int(Constants.screenWidth), height: Int(Constants.screenHeight) - 82 * 5 - 60 - 30)
      
        
        display.frame = CGRect(x: 15, y: 15, width: displayView.frame.width - 30, height: displayView.frame.height - 15)
        display.textAlignment = .right
        display.contentVerticalAlignment = .bottom
        display.text = "0"
        display.textColor = .white
        display.font = UIFont.systemFont(ofSize: 80)
        
        displayView.addSubview(display)
        mainVStack.addSubview(displayView)
    }
    
    func setupLine1() {
        let line1 = createHStack(yPosition: Int(displayView.frame.height))
        
        let acButton = createButton(order: 0, title: "AC", tag: 15)
        acButton.backgroundColor = AppColors.topButtons
        acButton.setTitleColor(.black, for: .normal)
        acButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        
        let changeSignButton = createButton(order: 1, title: "+/-", tag: 16)
        changeSignButton.backgroundColor = AppColors.topButtons
        changeSignButton.setTitleColor(.black, for: .normal)
        changeSignButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        
        let percentButton = createButton(order: 2, title: "%", tag: 17)
        percentButton.backgroundColor = AppColors.topButtons
        percentButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        
        let divButton = createButton(order: 3, title: "/", tag: 18)
        divButton.backgroundColor = AppColors.actions
        divButton.setTitleColor(.black, for: .normal)
        divButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        
        line1.addSubview(acButton)
        line1.addSubview(changeSignButton)
        line1.addSubview(percentButton)
        line1.addSubview(divButton)
        
        mainVStack.addSubview(line1)
    }
    
    func setupLine2() {
        let line2 = createHStack(yPosition: Int(displayView.frame.height) + 80 + 2)
        
        let sevenButton = createButton(order: 0, title: "7", tag: 7)
        sevenButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        
        let eightButton = createButton(order: 1, title: "8", tag: 8)
        eightButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        
        let nineButton = createButton(order: 2, title: "9", tag: 9)
        nineButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        
        let multButton = createButton(order: 3, title: "*", tag: 14)
        multButton.backgroundColor = AppColors.actions
        multButton.setTitleColor(.black, for: .normal)
        multButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        
        line2.addSubview(sevenButton)
        line2.addSubview(eightButton)
        line2.addSubview(nineButton)
        line2.addSubview(multButton)
        
        mainVStack.addSubview(line2)
    }
    
    func setupLine3() {
        let line3 = createHStack(yPosition: Int(displayView.frame.height) + 80 + 80 + 4)
        
        let fourButton = createButton(order: 0, title: "4", tag: 4)
        fourButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        
        let fiveButton = createButton(order: 1, title: "5", tag: 5)
        fiveButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        
        let sixButton = createButton(order: 2, title: "6", tag: 6)
        sixButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        
        let subtrButton = createButton(order: 3, title: "-", tag: 13)
        subtrButton.backgroundColor = AppColors.actions
        subtrButton.setTitleColor(.black, for: .normal)
        subtrButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        
        line3.addSubview(fourButton)
        line3.addSubview(fiveButton)
        line3.addSubview(sixButton)
        line3.addSubview(subtrButton)
        
        mainVStack.addSubview(line3)
    }
    
    func setupLine4() {
        let line4 = createHStack(yPosition: Int(displayView.frame.height) + 80 + 80 + 80 + 6)
        
        let oneButton = createButton(order: 0, title: "1", tag: 1)
        oneButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        
        let twoButton = createButton(order: 1, title: "2", tag: 2)
        twoButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        
        let threeButton = createButton(order: 2, title: "3", tag: 3)
        threeButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        
        let plusButton = createButton(order: 3, title: "+", tag: 12)
        plusButton.backgroundColor = AppColors.actions
        plusButton.setTitleColor(.black, for: .normal)
        plusButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        
        line4.addSubview(oneButton)
        line4.addSubview(twoButton)
        line4.addSubview(threeButton)
        line4.addSubview(plusButton)
        
        mainVStack.addSubview(line4)
    }
    
    func setupButtons() {
        setupLine1()
        setupLine2()
        setupLine3()
        setupLine4()
        
        let line5 = createHStack(yPosition: Int(displayView.frame.height) + 80 + 80 + 80 + 80 + 8)
        
        let zeroButton = createButton(order: 0, title: "0", tag: 0)
        zeroButton.frame = CGRect(x: 2, y: 0, width: Int(Constants.screenWidth / 4 ) * 2 - 2, height: 80)
        zeroButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        
        let dotButton = createButton(order: 2, title: ".", tag: 10)
        dotButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        
        let equalButton = createButton(order: 3, title: "=", tag: 11)
        equalButton.backgroundColor = AppColors.actions
        equalButton.setTitleColor(.black, for: .normal)
        equalButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        
        line5.addSubview(zeroButton)
        line5.addSubview(dotButton)
        line5.addSubview(equalButton)
        
        mainVStack.addSubview(line5)
    }
    
    func createButton(order: Int, title: String, tag: Int) -> UIButton {
        let button = UIButton(frame: CGRect(x: (Int(Constants.screenWidth/4) * order + 2), y: 0, width: Int(Constants.screenWidth) / 4 - 2, height: 80))
        button.setTitle(title, for: .normal)
        button.backgroundColor = AppColors.buttons
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        button.setTitleColor(.white, for: .normal)
        button.tag = tag
        return button
    }
    
    func createHStack(yPosition: Int) -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.frame = CGRect(x: 0, y: yPosition, width: Int(Constants.screenWidth), height: 80)
        return stack
    }
}

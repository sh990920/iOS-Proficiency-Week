//
//  ViewController.swift
//  ViewControllerLifeCycle
//
//  Created by 박승환 on 7/9/24.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        print("viewDidLoad")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
        self.view.backgroundColor = UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1.0
        )
            
        self.button.backgroundColor = UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1.0
        )
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        print("viewIsAppearing")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDisappear")
    }
    
    private func configureUI() {
        view.addSubview(button)
        view.backgroundColor = .white
        
        button.setTitle("페이지 이동", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchDown)
        button.backgroundColor = .red
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 30)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.snp.makeConstraints {
            $0.width.equalTo(200)
            $0.height.equalTo(120)
            $0.center.equalToSuperview()
        }
        
    }
    
    @objc
    private func buttonTapped() {
        self.navigationController?.pushViewController(NextViewController(), animated: true)
    }

}


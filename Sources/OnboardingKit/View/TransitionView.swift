//
//  TransitionView.swift
//  
//
//  Created by CONG LE on 9/2/22.
//

import UIKit

class TransitionView: UIView {
    
    private let slides: [Slide]
    private let viewTintColor: UIColor
    private var timer: DispatchSourceTimer?
    private var index: Int = -1
    
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.backgroundColor = .yellow
        return view
    }()
    
    private lazy var barViews: [AnimatedBarView] = {
        var views: [AnimatedBarView] = []
        slides.forEach { _ in
            views.append(AnimatedBarView())
        }
        return views
    }()
    
    private lazy var barStackView: UIStackView = {
        let stackView = UIStackView()
        barViews.forEach { barView in
            stackView.addArrangedSubview(barView)
        }
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var titleView: TitleView = {
        let view = TitleView()
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            imageView,
            titleView
        ])
        stackView.distribution = .fill
        stackView.axis = .vertical
        return stackView
    }()
    
    init(slides: [Slide], tintColor: UIColor) {
        self.slides = slides
        self.viewTintColor = tintColor
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func start() {
        buildTimerIfNeeded()
        timer?.resume() // since the timer stops by default
    }
    
    func stop() {
        timer?.cancel()
        timer = nil
    }
    
    private func buildTimerIfNeeded() {
        guard timer == nil else { return } // If timer is not nil, the nwe dont need to build the timer and just return
        timer = DispatchSource.makeTimerSource()
        timer?.schedule(deadline: .now(), repeating: .seconds(3), leeway: .seconds(1))
        timer?.setEventHandler(handler: { [weak self] in
            DispatchQueue.main.async {
                self?.showNext()
            }
        })
    }
    
    private func showNext() {
        let nextImage: UIImage
        // if index is last, then show first
        // else show next index
        if slides.indices.contains(index + 1) {
            nextImage = slides[index + 1].image
            index += 1
        } else {
            // we are on the last index
            nextImage = slides[0].image
            index = 0
        }
        UIView.transition(
            with: imageView,
            duration: 0.5,
            options: .transitionCrossDissolve,
            animations: {
                self.imageView.image = nextImage
            }, completion: nil
        )
    }
        
    private func layout() {
        backgroundColor = .blue
        addSubview(stackView)
        addSubview(barStackView)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
        barStackView.snp.makeConstraints { make in
            make.leading.equalTo(snp.leading).offset(24)
            make.trailing.equalTo(snp.trailing).offset(-24)
            make.top.equalTo(snp.topMargin)
            make.height.equalTo(4)
        }
        
        imageView.snp.makeConstraints { make in
            make.height.equalTo(stackView.snp.height).multipliedBy(0.8)
        }
    }
}

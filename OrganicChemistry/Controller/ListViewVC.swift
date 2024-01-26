//
//  ListViewVC.swift
//  OrganicChemistry
//
//  Created by 北村昌彦 on 2021/12/14.
//

import UIKit
import PDFKit

class ListViewVC: UIViewController, UIGestureRecognizerDelegate {
    
    //MARK: - properties
    
    // pdf property
    @IBOutlet weak var pdfView: PDFView!
    var annotations: [PDFAnnotation] = []
    var chapterName: String?
    var columnName: String?
    var pdfDocument: PDFDocument!
    var url: URL?
    @IBOutlet weak var buttons: UIButton!
    
    // output mode property
    @IBOutlet weak var outputModeButton: UIButton!
    var isOutputMode: Bool = true
    
    
    //MARK: - view Did/will Load
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(willShowMenu(_:)), name: UIMenuController.willShowMenuNotification, object: nil)
        removeDoubleTapGestureRecognizer(view: self.view)
        setupSingleTap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showPDF()
        switchOutputMode()
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

//MARK: - Mode controll
extension ListViewVC {
    
    @IBAction func isOutputModeButtonPressed(_ sender: UIButton) {
        switchOutputMode()
    }
    
    func switchOutputMode() {
        isOutputMode.toggle()
        let image = UIImage(systemName: isOutputMode ? "doc.plaintext" : "rays")
        outputModeButton.setImage(image, for: .normal)
        
        for annotation in getAnnotations() {
            annotation.shouldDisplay = isOutputMode
        }
    }
}

//MARK: - PDF
extension ListViewVC {
    
    func showPDF() {
        pdfDocument = QuizFiles.getExplainPDF(chapterName: chapterName!, columnName: columnName!)
        pdfView.backgroundColor = K.Color.accent
        
        pdfView.pageShadowsEnabled = true
        pdfView.disableBouncing()
        
        pdfView.displayDirection = .vertical

        pdfView.displayMode = .singlePageContinuous
        pdfView.displaysPageBreaks = true
        
        pdfView.document = pdfDocument
        
        pdfView.scaleFactor = pdfView.scaleFactorForSizeToFit
        pdfView.minScaleFactor = pdfView.scaleFactorForSizeToFit
        pdfView.maxScaleFactor = 4.0
        
        pdfView.autoScales = true
    }
    
    func getAnnotations() -> [PDFAnnotation] {
        var temp = [[PDFAnnotation]]()
        for i in 0..<pdfDocument.pageCount {
            temp.append(pdfDocument.page(at: i)!.annotations)
        }
        return Array(temp.joined())
    }
}

//MARK: - Gesture
extension ListViewVC {
    
    @objc func annotationClick(notification: Notification)  {
        if let userInfo = notification.userInfo?["PDFAnnotationHit"] as? PDFAnnotation {
            userInfo.shouldDisplay = false
        }
    }
    
    func removeDoubleTapGestureRecognizer(view: UIView) {
        if let gestureRecognizers = view.gestureRecognizers {
            for recognizerAnyObject in gestureRecognizers {
                if let tapRecognizer: UITapGestureRecognizer = recognizerAnyObject as? UITapGestureRecognizer {
                    if tapRecognizer.numberOfTapsRequired == 2 {
                        view.removeGestureRecognizer(tapRecognizer)
                    }
                }
            }
        }
        for subviewAnyObject in view.subviews {
            self.removeDoubleTapGestureRecognizer(view: subviewAnyObject as UIView)
        }
    }
    
    func setupSingleTap() {
        let longPressGesture = UILongPressGestureRecognizer (target: self, action: nil)
        longPressGesture.minimumPressDuration = 0.01
        longPressGesture.delegate = self
        self.view.addGestureRecognizer(longPressGesture)
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        // Buttons are tapped?
        if gestureRecognizer is UILongPressGestureRecognizer {
            
            let location = gestureRecognizer.location(in: self.view)
            
            if self.view.hitTest(location, with: nil) is UIButton {
                return false
                
            } else {
                
                // annotation operation
                if gestureRecognizer is UILongPressGestureRecognizer {
                    let tapLocation = gestureRecognizer.location(in: pdfView)
                    let tappedPage = pdfView.page(for: tapLocation, nearest: false)
                    if let page = tappedPage {
                        let tapPageLocation = pdfView.convert(tapLocation, to: page)
                        let annotation = page.annotation(at: tapPageLocation)
                        annotation?.shouldDisplay = false
                        return annotation != nil
                    }
                }
            }
        }
        
        return true
    }
}

//MARK: - Hide Menu
extension ListViewVC {
    
    @objc private func willShowMenu(_ notification: NSNotification) {
        DispatchQueue.main.async {
            UIView.performWithoutAnimation {
                UIMenuController.shared.hideMenu()
            }
        }
    }
    
    override public func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
       false
    }
}

//MARK: - PDFView extentions

private extension PDFView {
    func disableBouncing() {
        for subview in subviews {
            if let scrollView = subview as? UIScrollView {
                scrollView.showsVerticalScrollIndicator = false
                scrollView.alwaysBounceVertical = false
                
                return
            }
        }
    }
}

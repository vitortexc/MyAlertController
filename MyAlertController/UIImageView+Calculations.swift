//
//  UIImageView+Calculations.swift
//  MyAlertController
//
//  Created by Vitor Carrasco on 03/05/17.
//  Copyright © 2017 Empresinha. All rights reserved.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import UIKit

internal extension UIImageView {
	
	internal func heightLimited(to height: CGFloat) -> CGFloat {
		guard let image = image, image.size.height > 0 else {
			return 0.0
		}
		let ratio = image.size.height / image.size.width
		return height * ratio
	}
	
	internal func heightWithRatio() -> CGFloat {
		guard let image = image, image.size.height > 0 else {
			return 0.0
		}
		let width = bounds.size.width
		let ratio = image.size.height / image.size.width
		return width * ratio
	}
}


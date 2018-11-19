import UIKit

class MessageModel: Decodable {
    var sender: String = ""
    var textMessage: String = ""
    var time: TimeInterval?
}

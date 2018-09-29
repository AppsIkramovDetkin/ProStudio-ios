import UIKit

struct ChatModel {
    let sender: Bool!
    let image: UIImage!
    let textMessage: String!
    
    //MARK: - sender true -> from user fasle -> from manager
    static let arrayForSample = [
        ChatModel(sender: true, image: UIImage(named: "photo"), textMessage: "Добрый день с, сайтом возникла проблема. Не получается загрузить новые товары."),
        ChatModel(sender: false, image: UIImage(named: "photo1"), textMessage: "Добрый день, вы проводили  в последнее время, какие-нибудь работы на сайте?."),
        ChatModel(sender: true, image: UIImage(named: "photo"), textMessage: "Нет, я ничего не делал."),
        ChatModel(sender: false, image: UIImage(named: "photo1"), textMessage: "Хорошо, подождите. Сейчас сайт проверим"),
        ChatModel(sender: false, image: UIImage(named: "photo1"), textMessage: "Поправили!"),
        ChatModel(sender: true, image: UIImage(named: "photo"), textMessage: "We began to recognize in them a strange obsession. After all, they are emotionally inexperienced, with only a few years in which to store up the experiences which you and I take for granted. If we gift them with a past, we create a cushion or a pillow for their emotions, and consequently, we can control them better.."),
        ChatModel(sender: false, image: UIImage(named: "photo1"), textMessage: "Thats ok."),
        ChatModel(sender: false, image: UIImage(named: "photo1"), textMessage: "Memories! You're talking about memories!")
    ]
}

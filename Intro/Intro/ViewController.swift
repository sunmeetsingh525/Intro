import UIKit

struct Quote: Decodable {
    let quote: String
}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func fetchLuciferQuote(_ sender: UIButton) {
        if let url = URL(string: "https://lucifer-quotes.vercel.app/api/quotes") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let quotes = try JSONDecoder().decode([Quote].self, from: data)
                        if let luciferQuote = quotes.first {
                            print("Lucifer Quote: \(luciferQuote.quote)")
                        }
                    } catch {
                        print("Error decoding Lucifer quote data: \(error)")
                    }
                } else if let error = error {
                    print("Error fetching Lucifer quote: \(error)")
                }
            }.resume()
        }
    }
    
    @IBAction func fetchStrangerThingsQuote(_ sender: UIButton) {
        if let url = URL(string: "https://strangerthings-quotes.vercel.app/api/quotes") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let quotes = try JSONDecoder().decode([Quote].self, from: data)
                        if let strangerThingsQuote = quotes.first {
                            print("Stranger Things Quote: \(strangerThingsQuote.quote)")
                        }
                    } catch {
                        print("Error decoding Stranger Things quote data: \(error)")
                    }
                } else if let error = error {
                    print("Error fetching Stranger Things quote: \(error)")
                }
            }.resume()
        }
    }
    
    @IBAction func fetchBreakingBadQuote(_ sender: UIButton) {
        if let url = URL(string: "https://api.breakingbadquotes.xyz/v1/quotes") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        if let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                            // Handling the case where the response is an array
                            if let firstQuote = jsonArray.first, let quote = firstQuote["quote"] as? String {
                                print("Breaking Bad Quote: \(quote)")
                            }
                        } else if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any], let quote = jsonObject["quote"] as? String {
                            // Handling the case where the response is a dictionary
                            print("Breaking Bad Quote: \(quote)")
                        } else {
                            print("Error: Unable to decode Breaking Bad quote")
                        }
                    } catch {
                        print("Error decoding Breaking Bad quote data: \(error)")
                    }
                } else if let error = error {
                    print("Error fetching Breaking Bad quote: \(error)")
                }
            }.resume()
        }
    }
}

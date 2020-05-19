import UIKit

protocol WeatherDisplayLogic: class {
    func displayForecast(viewModel: WeatherModels.Forecast.ViewModel)
    func displayFailure(response: WeatherModels.Failure.ViewModel)
    func displayLoading()
}

final class WeatherViewController: UIViewController {
    
    var interactor: (WeatherBusinessLogic & FlightDelegate)?
    var router: (NSObjectProtocol & WeatherRoutingLogic & WeatherDataPassing)?
    
    // MARK: Data
    
    private struct Section {
        let title: String
        let forecasts: [WeatherCellViewModel]
    }
    
    private var sections: [Section] = []
    
    // MARK: Views
    
    @IBOutlet private var titleLabel: UILabel!
    
    @IBOutlet private var tableView: UITableView!
    
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
}

// MARK: - System

extension WeatherViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

// MARK: - Private

extension WeatherViewController {
    
    private func setup() {
        setupUI()
        loadData()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor.background
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshWeatherData(sender:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        setupTableViewSeparators()
        tableView.register(WeatherCellViewModel.self)
    }
    
    private func setupTableViewSeparators() {
        tableView.separatorStyle = sections.isEmpty ? .singleLine : .none
    }
    
    private func loadData() {
        let request = WeatherModels.Forecast.Request()
        interactor?.loadForecast(request: request)
    }
}

// MARK: - @IBActions
extension WeatherViewController {
    @objc private func refreshWeatherData(sender: UIRefreshControl) {
        loadData()
    }
}

// MARK: - Table View

// MARK: Data Source
extension WeatherViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(with: itemModel(at: indexPath), for: indexPath)
    }
    
    private func itemModel(at indexPath: IndexPath) -> AnyCellViewModel {
        return sections[indexPath.section].forecasts[indexPath.item]
    }
}

// MARK: Delegate
extension WeatherViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
}

// MARK: - Display logic

extension WeatherViewController: WeatherDisplayLogic  {
    func displayForecast(viewModel: WeatherModels.Forecast.ViewModel) {
        activityIndicator.stopAnimating()
        
        titleLabel.text = viewModel.title
        sections = viewModel.sections.map { section in
            Section(
                title: section.title,
                forecasts: section.forecasts.map {
                    WeatherCellViewModel(
                        windSpeed: $0.windSpeed,
                        windDegree: $0.windDegree,
                        clouds: $0.clouds,
                        temperature: $0.temperature,
                        pressure: $0.pressure,
                        description: $0.description,
                        icon: $0.icon,
                        date: $0.date
                    )
                }
            )
        }
        setupTableViewSeparators()
        
        tableView.backgroundView = nil
        tableView.refreshControl?.endRefreshing()
        tableView.reloadData()
    }
    
    func displayFailure(response: WeatherModels.Failure.ViewModel) {
        activityIndicator.stopAnimating()
        
        titleLabel.text = response.title
        
        sections = []
        setupTableViewSeparators()
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = response.errorMessage
        
        let backgroundView = UIView()
        backgroundView.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor)
        ])
        
        tableView.backgroundView = backgroundView
        tableView.refreshControl?.endRefreshing()
        tableView.reloadData()
    }
    
    func displayLoading() {
        if let refreshControl = tableView.refreshControl, !refreshControl.isRefreshing {
            activityIndicator.startAnimating()
        }
        titleLabel.text = nil
        sections = []
        setupTableViewSeparators()
        tableView.backgroundView = nil
        tableView.reloadData()
    }
}

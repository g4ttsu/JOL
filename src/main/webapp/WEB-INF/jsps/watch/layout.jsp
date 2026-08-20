<div class="card shadow flex-fill d-flex flex-column min-h-0">
    <div class="card-header bg-body-secondary p-0">
        <ul class="nav nav-tabs card-header-tabs ms-0 border-0" role="tablist">
            <li class="nav-item" role="presentation">
                <button class="nav-link active px-3 py-2" data-bs-toggle="tab"
                        data-bs-target="#activeGamesPane" type="button" role="tab">
                    Active Games
                </button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link px-3 py-2" data-bs-toggle="tab"
                        data-bs-target="#pastGamesPane" type="button" role="tab">
                    Past Games
                </button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link px-3 py-2" data-bs-toggle="tab"
                        onclick="renderStats()"
                        data-bs-target="#statGamesPane" type="button" role="tab">
                    Statistics
                </button>
            </li>
            <li class="ms-auto d-flex align-items-center pe-2">
                <button class="btn btn-outline-secondary btn-sm d-none" id="exportCsvBtn"
                        onclick="exportCsv()">Export CSV <i class="bi-download"></i></button>
            </li>
        </ul>
    </div>
    <div class="tab-content tab-content-fill">
        <div class="tab-pane fade show active" id="activeGamesPane" role="tabpanel">
            <table id="activeGames" class="table table-sm table-hover mb-0">
                <thead>
                <tr>
                    <th>Game</th>
                    <th>Current Turn</th>
                    <th>Updated</th>
                </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>
        <div class="tab-pane fade" id="pastGamesPane" role="tabpanel">
            <table id="pastGames" class="table table-sm table-hover mb-0">
                <thead>
                <tr>
                    <th>Game</th>
                    <th>Started</th>
                    <th>Ended</th>
                    <th colspan="3">Results</th>
                </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>
        <div class="tab-pane fade overflow-hidden" id="statGamesPane" role="tabpanel">
            <div class="container mt-3">
                <div class="row align-items-center g-2">
                    <div class="col-auto">
                        <label for="fromDate" class="form-label mb-0">From</label>
                    </div>
                    <div class="col-auto">
                        <input type="date" class="form-control" id="fromDate">
                    </div>

                    <div class="col-auto">
                        <label for="toDate" class="form-label mb-0">To</label>
                    </div>
                    <div class="col-auto">
                        <input type="date" class="form-control" id="toDate">
                    </div>

                    <div class="col-auto">
                        <button onclick="renderStats()" type="button" class="btn btn-outline-secondary btn-sm">Search
                        </button>
                    </div>
                    <div class="col-auto">
                        <button type="button" class="btn btn-outline-secondary btn-sm"
                                onclick="renderStatsFor(new Date().getFullYear()-1 + '-01-01', new Date().getFullYear()-1 + '-12-31')">
                            Last Year
                        </button>
                    </div>
                    <div class="col-auto">
                        <button type="button" class="btn btn-outline-secondary btn-sm"
                                onclick="renderStatsFor(new Date().getFullYear() + '-01-01', new Date().getFullYear() + '-12-31')">
                            Current Year
                        </button>
                    </div>
                    <div class="col-auto">
                        <button class="btn btn-outline-secondary btn-sm" title="Reset all filter" onclick="resetStats()"><i class="bi-trash"></i></button>
                    </div>
                    <div class="form-check form-switch col-auto m-2 pt-1">
                        <input class="form-check-input" type="checkbox" role="switch" id="onlyTournaments" switch=""
                               onclick="renderStats()">
                        <label class="form-check-label" for="onlyTournaments">Only Tournaments</label>
                    </div>
                </div>
            </div>
            <ul class="nav nav-tabs mt-3">
                <li class="nav-item">
                    <button id="playerStatsTab"
                            class="nav-link active"
                            onclick="renderStats()"
                            data-bs-toggle="tab"
                            data-bs-target="#playerStatsPane">
                        Players
                    </button>
                </li>
                <li class="nav-item">
                    <button id="deckStatsTab"
                            class="nav-link"
                            onclick="renderStats()"
                            data-bs-toggle="tab"
                            data-bs-target="#deckStatsPane">
                        Decks
                    </button>
                </li>
                <li class="nav-item">
                    <button id="nationStatsTab"
                            class="nav-link"
                            onclick="renderStats()"
                            data-bs-toggle="tab"
                            data-bs-target="#nationStatsPane">
                        Nations
                    </button>
                </li>
                <li class="nav-item">
                    <button id="personalStatsTab"
                            class="nav-link"
                            onclick="renderStats()"
                            data-bs-toggle="tab"
                            data-bs-target="#personalStatsPane">
                        Personal
                    </button>
                </li>

                <li class="nav-item">
                    <button id="gameStatsTab"
                            class="nav-link"
                            onclick="renderStats()"
                            data-bs-toggle="tab"
                            data-bs-target="#gameStatsPane">
                        Games
                    </button>
                </li>

                <li class="nav-item">
                    <button id="jolStatsTab"
                            class="nav-link"
                            onclick="renderStats()"
                            data-bs-toggle="tab"
                            data-bs-target="#jolStatsPane">
                        Jol
                    </button>
                </li>
                <li class="nav-item">
                    <button id="metricsTab"
                            class="nav-link"
                            onclick="renderStats()"
                            data-bs-toggle="tab"
                            data-bs-target="#metricsPane">
                        Player Activity
                    </button>
                </li>
                <li class="nav-item">
                    <button id="metricsGameTab"
                            class="nav-link"
                            onclick="renderStats()"
                            data-bs-toggle="tab"
                            data-bs-target="#metricsGamesPane">
                        Games Activity
                    </button>
                </li>
                <li class="nav-item">
                    <button id="commandsPlayerTab"
                            class="nav-link"
                            onclick="renderStats()"
                            data-bs-toggle="tab"
                            data-bs-target="#commandsPlayerPane">
                        Player Commands
                    </button>
                </li>
                <li class="nav-item">
                    <button id="commandsGameTab"
                            class="nav-link"
                            onclick="renderStats()"
                            data-bs-toggle="tab"
                            data-bs-target="#commandsGamePane">
                        Game Commands
                    </button>
                </li>
            </ul>

            <div class="tab-content mt-3">

                <!-- Player Stats -->
                <div class="tab-pane fade show active" id="playerStatsPane">
                    <div class="overflow-auto pb-3" style="height:78vh;">
                        <table id="statsGames" class="table table-bordered table-sm mb-0">
                            <thead>
                            <tr>
                                <th class="sticky-top bg-white">Player
                                    <input type="text" id="playerNameFilter"
                                           oninput="filterName('#statsGames tbody tr', 'playerNameFilter', 1)">
                                    <i class="bi bi-filter" onclick="sortTable(0, 'statsGames')"></i></th>
                                <th class="sticky-top bg-white">Number of Games
                                    <input type="number" id="gameThreshold" min="0" value="0"
                                           oninput="renderStats()" style="width: 45px; height: 25px;">
                                    <i class="bi bi-filter" onclick="sortTable(1, 'statsGames')"></i>
                                </th>
                                <th class="sticky-top bg-white">GW Total <i class="bi bi-filter"
                                                                            onclick="sortTable(2, 'statsGames')"></i>
                                </th>
                                <th class="sticky-top bg-white">VP Total <i class="bi bi-filter"
                                                                            onclick="sortTable(3, 'statsGames')"></i>
                                </th>
                                <th class="sticky-top bg-white">% Win Rate <i class="bi bi-filter"
                                                                              onclick="sortPercentageTable(4, 'statsGames')"></i>
                                </th>
                                <th class="sticky-top bg-white">Average VP <i class="bi bi-filter"
                                                                              onclick="sortTable(5, 'statsGames')"></i>
                                </th>
                                <th class="sticky-top bg-white">Highest VP <i class="bi bi-filter"
                                                                              onclick="sortTable(6, 'statsGames')"></i>
                                </th>
                                <th class="sticky-top bg-white">Unique Opponents <i class="bi bi-filter"
                                                                              onclick="sortTable(7, 'statsGames')"></i>
                                </th>
                                <th class="sticky-top bg-white">Most played Opponent <i class="bi bi-filter"
                                                                              onclick="sortTable(8, 'statsGames')"></i>
                                </th>
                                <th class="sticky-top bg-white">Highest Win Streak <i class="bi bi-filter"
                                                                                      onclick="sortTable(9, 'statsGames')"></i>
                                </th>
                            </tr>
                            </thead>
                            <tbody></tbody>
                        </table>
                    </div>

                </div>

                <!-- Deck Stats -->
                <div class="tab-pane fade" id="deckStatsPane">
                    <div class="overflow-auto pb-3" style="height:78vh;">
                        <table id="statsDeckGames" class="table table-bordered table-sm mb-0">
                            <thead>
                            <tr>
                                <th class="sticky-top bg-white w-25">Deck / Player
                                    <input type="text" id="deckNameFilter"
                                           oninput="filterName('#statsDeckGames tbody tr', 'deckNameFilter', 1)">
                                    <i class="bi bi-filter" onclick="sortTable(0, 'statsDeckGames')"></i></th>
                                <th class="sticky-top bg-white">Number of Games
                                    <input type="number" id="gameThresholdDeck" min="0" value="0"
                                           oninput="renderStats()" style="width: 45px; height: 25px;">
                                    <i class="bi bi-filter" onclick="sortTable(1, 'statsDeckGames')"></i>
                                </th>
                                <th class="sticky-top bg-white">GW Total <i class="bi bi-filter"
                                                                            onclick="sortTable(2, 'statsDeckGames')"></i>
                                </th>
                                <th class="sticky-top bg-white">VP Total <i class="bi bi-filter"
                                                                            onclick="sortTable(3, 'statsDeckGames')"></i>
                                </th>
                                <th class="sticky-top bg-white">% Win Rate <i class="bi bi-filter"
                                                                              onclick="sortPercentageTable(4, 'statsDeckGames')"></i>
                                </th>
                                <th class="sticky-top bg-white">Average VP <i class="bi bi-filter"
                                                                              onclick="sortTable(5, 'statsDeckGames')"></i>
                                </th>
                                <th class="sticky-top bg-white">Highest VP <i class="bi bi-filter"
                                                                              onclick="sortTable(6, 'statsDeckGames')"></i>
                                </th>
                                <th class="sticky-top bg-white">Highest Win Streak <i class="bi bi-filter"
                                                                                      onclick="sortTable(9, 'statsDeckGames')"></i>
                                </th>
                            </tr>
                            </thead>
                            <tbody></tbody>
                        </table>
                    </div>
                </div>

                <!-- Nation Stats -->
                <div class="tab-pane fade" id="nationStatsPane">
                    <div class="overflow-auto pb-3" style="height:78vh;">
                        <table id="statsNationGames" class="table table-sm mb-0"><thead>
                            <tr>
                                <th class="sticky-top bg-white">Nation
                                    <input type="text" id="nationNameFilter"
                                           oninput="filterName('#statsNationGames tbody tr', 'nationNameFilter', 1)">
                                    <i class="bi bi-filter" onclick="sortTable(0, 'statsNationGames')"></i></th>
                                <th class="sticky-top bg-white">Number of Games
                                    <input type="number" id="gameThresholdNation" min="0" value="0"
                                           oninput="renderStats()" style="width: 45px; height: 25px;">
                                    <i class="bi bi-filter" onclick="sortTable(1, 'statsNationGames')"></i>
                                </th>
                                <th class="sticky-top bg-white">GW Total <i class="bi bi-filter"
                                                                            onclick="sortTable(2, 'statsNationGames')"></i></th>
                                <th class="sticky-top bg-white">VP Total <i class="bi bi-filter"
                                                                            onclick="sortTable(3, 'statsNationGames')"></i></th>
                                <th class="sticky-top bg-white">% Win Rate <i class="bi bi-filter"
                                                                              onclick="sortPercentageTable(4, 'statsNationGames')"></i></th>
                                <th class="sticky-top bg-white">Average VP <i class="bi bi-filter"
                                                                              onclick="sortTable(5, 'statsNationGames')"></i></th>
                                <th class="sticky-top bg-white">Highest VP <i class="bi bi-filter"
                                                                              onclick="sortTable(6, 'statsNationGames')"></i>
                                </th>
                                <th class="sticky-top bg-white">Highest Win Streak <i class="bi bi-filter"
                                                                                    onclick="sortTable(9, 'statsNationGames')"></i>
                                </th>
                            </tr>
                            </thead>
                            <tbody></tbody>
                        </table>
                    </div>
                </div>

                <!-- Game Stats -->
                <div class="tab-pane fade"
                     id="gameStatsPane">
                    <div class="overflow-auto pb-3" style="height:78vh;">
                        <table id="statsGameGames" class="table table-bordered table-sm mb-0">
                            <thead>
                            <tr>
                                <th class="sticky-top bg-white">Game
                                    <input type="text" id="gameNameFilter"
                                           oninput="filterName('#statsGameGames tbody tr', 'gameNameFilter', 1)">
                                    <i class="bi bi-filter" onclick="sortTable(0, 'statsGameGames')"></i></th>
                                <th class="sticky-top bg-white">Players
                                    <input type="text" id="gamePlayerFilter"
                                           oninput="filterName('#statsGameGames tbody tr', 'gamePlayerFilter', 2)">
                                    <i class="bi bi-filter" onclick="sortTable(1, 'statsGameGames')"></i></th>

                                </th>
                                <th class="sticky-top bg-white">Duration
                                    <i class="bi bi-filter" onclick="sortTableByDuration(2)"></i>
                                </th>
                                </th>
                                <th class="sticky-top bg-white">GW?
                                    <i class="bi bi-filter" onclick="sortTableByBoolean(3)"></i>
                                </th>
                                </th>
                                <th class="sticky-top bg-white">VPs
                                    <i class="bi bi-filter" onclick="sortTable(4, 'statsGameGames')"></i>
                                </th>
                            </tr>
                            </thead>
                            <tbody></tbody>
                        </table>
                    </div>
                </div>

                <!-- Jol Stats -->
                <div class="tab-pane fade" id="jolStatsPane">
                    <div class="overflow-auto pb-3" style="height:78vh;">
                        <table id="statsJolGames" class="table table-bordered table-sm mb-0">
                            <thead>
                            <tr>
                                <th class="sticky-top bg-white">Month
                                    <input type="text" id="monthFilter"
                                           oninput="filterName('#statsJolGames tbody tr', 'monthFilter', 1)">
                                    <i class="bi bi-filter" onclick="sortTable(0, 'statsJolGames')"></i></th>
                                <th class="sticky-top bg-white">Games Started
                                    <i class="bi bi-filter" onclick="sortTable(1, 'statsJolGames')"></i></th>
                                <th class="sticky-top bg-white">Games Ended
                                    <i class="bi bi-filter" onclick="sortTable(2, 'statsJolGames')"></i></th>
                                <th class="sticky-top bg-white">Net
                                    <i class="bi bi-filter" onclick="sortTable(3, 'statsJolGames')"></i></th>
                                <th class="sticky-top bg-white">Wins
                                    <i class="bi bi-filter" onclick="sortTable(4, 'statsJolGames')"></i></th>
                                <th class="sticky-top bg-white">Win Rate
                                    <i class="bi bi-filter" onclick="sortTable(5, 'statsJolGames')"></i></th>
                                <th class="sticky-top bg-white">Vp
                                    <i class="bi bi-filter" onclick="sortTable(6, 'statsJolGames')"></i></th>
                                <th class="sticky-top bg-white">Avg Vp
                                    <i class="bi bi-filter" onclick="sortTable(7, 'statsJolGames')"></i></th>
                                <th class="sticky-top bg-white">Avg Duration
                                    <i class="bi bi-filter" onclick="sortTable(8, 'statsJolGames')"></i></th>
                                <th class="sticky-top bg-white">Player of the Month
                                    <i class="bi bi-filter" onclick="sortTable(9, 'statsJolGames')"></i></th>
                                <th class="sticky-top bg-white w-25">Deck of the Month
                                    <i class="bi bi-filter" onclick="sortTable(10, 'statsJolGames')"></i></th>
                                <th class="sticky-top bg-white">Nation of the Month
                                    <i class="bi bi-filter" onclick="sortTable(11, 'statsJolGames')"></i></th>
                            </tr>
                            </thead>
                            <tbody></tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- Personal Stats -->
            <div class="tab-pane fade" id="personalStatsPane">
                <!-- Personal Statistics Sub-Tabs -->
                <ul class="nav nav-tabs mt-3" id="personalStatsSubTabs">
                    <li class="nav-item">
                        <button class="nav-link active"
                                id="personalOverviewTab"
                                data-bs-toggle="tab"
                                data-bs-target="#personalOverviewPane"
                                type="button">
                            Opponent Performance
                        </button>
                    </li>
                    <li class="nav-item">
                        <button class="nav-link"
                                id="personalOpponentTab"
                                data-bs-toggle="tab"
                                data-bs-target="#personalOpponentPane"
                                type="button">
                            Deck Performance
                        </button>
                    </li>
                </ul>

                <!-- Personal Statistics Sub-Tab Content -->
                <div class="tab-content mt-3">

                    <!-- Opponent -->
                    <div class="tab-pane fade show active" id="personalOverviewPane">
                        <div class="overflow-auto pb-3" style="height:73vh;">
                            <table id="statsPersonalGames" class="table table-bordered table-sm mb-0"><thead>
                                <tr>
                                    <th class="sticky-top bg-white">Opponent
                                        <input type="text" id="personalNameFilter" oninput="filterName('#statsPersonalGames tbody tr', 'personalNameFilter', 0)">
                                        <i class="bi bi-filter" onclick="sortTable(0, 'statsPersonalGames')"></i>
                                    </th>
                                    <th class="sticky-top bg-white">Number of Games
                                        <i class="bi bi-filter" onclick="sortTable(1, 'statsPersonalGames')"></i>
                                    </th>
                                    <th class="sticky-top bg-white">Wins
                                        <i class="bi bi-filter" onclick="sortTable(2, 'statsPersonalGames')"></i>
                                    </th>
                                    <th class="sticky-top bg-white">Win Rate
                                        <i class="bi bi-filter" onclick="sortPercentageTable(3, 'statsPersonalGames')"></i>
                                    </th>
                                    <th class="sticky-top bg-white">Opponent Won
                                        <i class="bi bi-filter" onclick="sortTable(4, 'statsPersonalGames')"></i>
                                    </th>
                                    <th class="sticky-top bg-white">Win Rate Against Opponent
                                        <i class="bi bi-filter" onclick="sortPercentageTable(5, 'statsPersonalGames')"></i>
                                    </th>
                                    <th class="sticky-top bg-white">Other player won
                                        <i class="bi bi-filter" onclick="sortTable(6, 'statsPersonalGames')"></i>
                                    </th>
                                    <th class="sticky-top bg-white">Losses
                                        <i class="bi bi-filter" onclick="sortTable(7, 'statsPersonalGames')"></i>
                                    </th>
                                </tr>
                                </thead>
                                <tbody></tbody>
                            </table>
                        </div>
                    </div>

                    <!-- Deck Performance -->
                    <div class="tab-pane fade" id="personalOpponentPane">
                        <div class="overflow-auto pb-3" style="height:73vh;">
                            <table id="statsPersonalDecks" class="table table-bordered table-sm mb-0"><thead>
                                <tr>
                                    <th class="sticky-top bg-white">Deck
                                        <input type="text" id="personalDeckNameFilter" oninput="filterName('#statsPersonalDecks tbody tr', 'personalDeckNameFilter', 1)">
                                        <i class="bi bi-filter" onclick="sortTable(0, 'statsPersonalDecks')"></i>
                                    </th>
                                    <th class="sticky-top bg-white">Opponent Deck
                                        <input type="text" id="personalOpponentNameFilter" oninput="filterName('#statsPersonalDecks tbody tr', 'personalOpponentNameFilter', 2)">
                                        <i class="bi bi-filter" onclick="sortTable(1, 'statsPersonalDecks')"></i></th>
                                    <th class="sticky-top bg-white">Game Names
                                        <input type="text" id="personalGamesNameFilter" oninput="filterName('#statsPersonalDecks tbody tr', 'personalGamesNameFilter', 3)">
                                        <i class="bi bi-filter" onclick="sortTable(2, 'statsPersonalDecks')"></i></th>
                                    <th class="sticky-top bg-white">Games
                                        <i class="bi bi-filter" onclick="sortTable(3, 'statsPersonalDecks')"></i></th>
                                    <th class="sticky-top bg-white">Wins
                                        <i class="bi bi-filter" onclick="sortTable(4, 'statsPersonalDecks')"></i></th>
                                    <th class="sticky-top bg-white">VP
                                        <i class="bi bi-filter" onclick="sortTable(5, 'statsPersonalDecks')"></i></th>
                                    <th class="sticky-top bg-white">Avg VP
                                        <i class="bi bi-filter" onclick="sortTable(6, 'statsPersonalDecks')"></i></th>
                                    <th class="sticky-top bg-white">Opponent VP
                                        <i class="bi bi-filter" onclick="sortTable(7, 'statsPersonalDecks')"></i></th>
                                    <th class="sticky-top bg-white">Opponent Avg VP
                                        <i class="bi bi-filter" onclick="sortTable(8, 'statsPersonalDecks')"></i></th>
                                    <th class="sticky-top bg-white">VP Difference
                                        <i class="bi bi-filter" onclick="sortTable(9, 'statsPersonalDecks')"></i></th>
                                </tr>
                                </thead>
                                <tbody></tbody>
                            </table>
                        </div>
                    </div>
                </div>

                </div>

                <!-- Player Metrics -->

                <div class="tab-pane fade"
                     id="metricsPane">

                    <div class="overflow-auto" style="max-height:100vh;">
                        <table id="playerMetrics" class="table table-sm mb-0">
                            <thead>
                            <tr>
                                <th class="sticky-top bg-white">Player
                                    <input type="text" id="playerMetricsFilter"
                                           oninput="filterName('#playerMetrics tbody tr', 'playerMetricsFilter', 1)">
                                    <i class="bi bi-filter" onclick="sortTable(0, 'playerMetrics')"></i></th>
                                <th class="sticky-top bg-white">All
                                    <i class="bi bi-filter" onclick="sortTable(1, 'playerMetrics')"></i>
                                </th>
                                <th class="sticky-top bg-white">Chat
                                    <i class="bi bi-filter" onclick="sortTable(2, 'playerMetrics')"></i>
                                </th>
                                <th class="sticky-top bg-white">Command
                                    <i class="bi bi-filter" onclick="sortTable(3, 'playerMetrics')"></i>
                                </th>
                                <th class="sticky-top bg-white">Chat & Command
                                    <i class="bi bi-filter" onclick="sortTable(4, 'playerMetrics')"></i>
                                </th>
                                <th class="sticky-top bg-white">Ping
                                    <i class="bi bi-filter" onclick="sortTable(5, 'playerMetrics')"></i>
                                </th>
                            </tr>
                            </thead>
                            <tbody></tbody>
                        </table>
                    </div>

                </div>

                <!-- Games Metrics -->
                <div class="tab-pane fade" id="metricsGamesPane">
                    <div class="overflow-auto" style="max-height:100vh;">
                        <table id="gamesMetrics" class="table table-sm mb-0">
                            <thead>
                            <tr>
                                <th class="sticky-top bg-white">Game
                                    <input type="text" id="gameMetricsFilter"
                                           oninput="filterName('#gamesMetrics tbody tr', 'gameMetricsFilter', 1)">
                                    <i class="bi bi-filter" onclick="sortTable(0, 'gamesMetrics')"></i></th>
                                <th class="sticky-top bg-white">All
                                    <i class="bi bi-filter" onclick="sortTable(1, 'gamesMetrics')"></i>
                                </th>
                                <th class="sticky-top bg-white">Chat
                                    <i class="bi bi-filter" onclick="sortTable(2, 'gamesMetrics')"></i>
                                </th>
                                <th class="sticky-top bg-white">Command
                                    <i class="bi bi-filter" onclick="sortTable(3, 'gamesMetrics')"></i>
                                </th>
                                <th class="sticky-top bg-white">Chat & Command
                                    <i class="bi bi-filter" onclick="sortTable(4, 'gamesMetrics')"></i>
                                </th>
                                <th class="sticky-top bg-white">Ping
                                    <i class="bi bi-filter" onclick="sortTable(5, 'playerMetrics')"></i>
                                </th>
                            </tr>
                            </thead>
                            <tbody></tbody>
                        </table>
                    </div>
                </div>

                <!-- Player Commands -->
                <div class="tab-pane fade" id="commandsPlayerPane">
                    <div class="overflow-auto" style="max-height:100vh;">
                        <table id="playerCommands" class="table table-sm mb-0">
                            <thead>
                            <tr>
                                <th class="sticky-top bg-white">Player
                                    <input type="text" id="playerCommandFilter"
                                           oninput="filterName('#playerCommands tbody tr', 'playerCommandFilter', 1)">
                                    <i class="bi bi-filter" onclick="sortTable(0, 'playerCommands')"></i></th>
                                <th class="sticky-top bg-white">Timeout
                                    <i class="bi bi-filter" onclick="sortTable(1, 'playerCommands')"></i>
                                </th>
                                <th class="sticky-top bg-white">VP
                                    <i class="bi bi-filter" onclick="sortTable(2, 'playerCommands')"></i>
                                </th>
                                <th class="sticky-top bg-white">Choose
                                    <i class="bi bi-filter" onclick="sortTable(3, 'playerCommands')"></i>
                                </th>
                                <th class="sticky-top bg-white">Reveal
                                    <i class="bi bi-filter" onclick="sortTable(4, 'playerCommands')"></i>
                                </th>
                                <th class="sticky-top bg-white">Label
                                    <i class="bi bi-filter" onclick="sortTable(5, 'playerCommands')"></i>
                                </th>
                                <th class="sticky-top bg-white">Votes
                                    <i class="bi bi-filter" onclick="sortTable(6, 'playerCommands')"></i>
                                </th>
                                <th class="sticky-top bg-white">Random
                                    <i class="bi bi-filter" onclick="sortTable(7, 'playerCommands')"></i>
                                </th>
                                <th class="sticky-top bg-white">Flip
                                    <i class="bi bi-filter" onclick="sortTable(8, 'playerCommands')"></i>
                                </th>
                                <th class="sticky-top bg-white">Discard
                                    <i class="bi bi-filter" onclick="sortTable(9, 'playerCommands')"></i>
                                </th>
                                <th class="sticky-top bg-white">Draw
                                    <i class="bi bi-filter" onclick="sortTable(10, 'playerCommands')"></i>
                                </th>
                                <th class="sticky-top bg-white">Edge
                                    <i class="bi bi-filter" onclick="sortTable(11, 'playerCommands')"></i>
                                </th>
                                <th class="sticky-top bg-white">Play
                                    <i class="bi bi-filter" onclick="sortTable(12, 'playerCommands')"></i>
                                </th>
                                <th class="sticky-top bg-white">Influence
                                    <i class="bi bi-filter" onclick="sortTable(13, 'playerCommands')"></i>
                                </th>
                                <th class="sticky-top bg-white">Move
                                    <i class="bi bi-filter" onclick="sortTable(14, 'playerCommands')"></i>
                                </th>
                                <th class="sticky-top bg-white">Burn
                                    <i class="bi bi-filter" onclick="sortTable(15, 'playerCommands')"></i>
                                </th>
                                <th class="sticky-top bg-white">Pool
                                    <i class="bi bi-filter" onclick="sortTable(16, 'playerCommands')"></i>
                                </th>
                                <th class="sticky-top bg-white">Blood
                                    <i class="bi bi-filter" onclick="sortTable(17, 'playerCommands')"></i>
                                </th>
                                <th class="sticky-top bg-white">Contest
                                    <i class="bi bi-filter" onclick="sortTable(18, 'playerCommands')"></i>
                                </th>
                                <th class="sticky-top bg-white">Disc
                                    <i class="bi bi-filter" onclick="sortTable(19, 'playerCommands')"></i>
                                </th>
                                <th class="sticky-top bg-white">Capacity
                                    <i class="bi bi-filter" onclick="sortTable(20, 'playerCommands')"></i>
                                </th>
                                <th class="sticky-top bg-white">Unlock
                                    <i class="bi bi-filter" onclick="sortTable(21, 'playerCommands')"></i>
                                </th>
                                <th class="sticky-top bg-white">Lock
                                    <i class="bi bi-filter" onclick="sortTable(22, 'playerCommands')"></i>
                                </th>
                                <th class="sticky-top bg-white">Order
                                    <i class="bi bi-filter" onclick="sortTable(23, 'playerCommands')"></i>
                                </th>
                                <th class="sticky-top bg-white">Show
                                    <i class="bi bi-filter" onclick="sortTable(24, 'playerCommands')"></i>
                                </th>
                                <th class="sticky-top bg-white">Shuffle
                                    <i class="bi bi-filter" onclick="sortTable(25, 'playerCommands')"></i>
                                </th>
                                <th class="sticky-top bg-white">Transfer
                                    <i class="bi bi-filter" onclick="sortTable(26, 'playerCommands')"></i>
                                </th>
                                <th class="sticky-top bg-white">Rfg
                                    <i class="bi bi-filter" onclick="sortTable(27, 'playerCommands')"></i>
                                </th>
                                <th class="sticky-top bg-white">Path
                                    <i class="bi bi-filter" onclick="sortTable(28, 'playerCommands')"></i>
                                </th>
                                <th class="sticky-top bg-white">Sect
                                    <i class="bi bi-filter" onclick="sortTable(29, 'playerCommands')"></i>
                                </th>
                                <th class="sticky-top bg-white">Clan
                                    <i class="bi bi-filter" onclick="sortTable(30, 'playerCommands')"></i>
                                </th>
                                <th class="sticky-top bg-white">Open
                                    <i class="bi bi-filter" onclick="sortTable(31, 'playerCommands')"></i>
                                </th>
                            </tr>
                            </thead>
                            <tbody></tbody>
                        </table>
                    </div>
                </div>

                <!-- Gamme Commands -->
                <div class="tab-pane fade" id="commandsGamePane">
                    <div class="overflow-auto" style="max-height:100vh;">
                        <table id="gameCommands" class="table table-sm mb-0">
                            <thead>
                            <tr>
                                <th class="sticky-top bg-white">Game
                                    <input type="text" id="gameCommandFilter"
                                           oninput="filterName('#gameCommands tbody tr', 'gameCommandFilter', 1)">
                                    <i class="bi bi-filter" onclick="sortTable(0, 'gameCommands')"></i></th>
                                <th class="sticky-top bg-white">Timeout
                                    <i class="bi bi-filter" onclick="sortTable(1, 'gameCommands')"></i>
                                </th>
                                <th class="sticky-top bg-white">VP
                                    <i class="bi bi-filter" onclick="sortTable(2, 'gameCommands')"></i>
                                </th>
                                <th class="sticky-top bg-white">Choose
                                    <i class="bi bi-filter" onclick="sortTable(3, 'gameCommands')"></i>
                                </th>
                                <th class="sticky-top bg-white">Reveal
                                    <i class="bi bi-filter" onclick="sortTable(4, 'gameCommands')"></i>
                                </th>
                                <th class="sticky-top bg-white">Label
                                    <i class="bi bi-filter" onclick="sortTable(5, 'gameCommands')"></i>
                                </th>
                                <th class="sticky-top bg-white">Votes
                                    <i class="bi bi-filter" onclick="sortTable(6, 'gameCommands')"></i>
                                </th>
                                <th class="sticky-top bg-white">Random
                                    <i class="bi bi-filter" onclick="sortTable(7, 'gameCommands')"></i>
                                </th>
                                <th class="sticky-top bg-white">Flip
                                    <i class="bi bi-filter" onclick="sortTable(8, 'gameCommands')"></i>
                                </th>
                                <th class="sticky-top bg-white">Discard
                                    <i class="bi bi-filter" onclick="sortTable(9, 'gameCommands')"></i>
                                </th>
                                <th class="sticky-top bg-white">Draw
                                    <i class="bi bi-filter" onclick="sortTable(10, 'gameCommands')"></i>
                                </th>
                                <th class="sticky-top bg-white">Edge
                                    <i class="bi bi-filter" onclick="sortTable(11, 'gameCommands')"></i>
                                </th>
                                <th class="sticky-top bg-white">Play
                                    <i class="bi bi-filter" onclick="sortTable(12, 'gameCommands')"></i>
                                </th>
                                <th class="sticky-top bg-white">Influence
                                    <i class="bi bi-filter" onclick="sortTable(13, 'gameCommands')"></i>
                                </th>
                                <th class="sticky-top bg-white">Move
                                    <i class="bi bi-filter" onclick="sortTable(14, 'gameCommands')"></i>
                                </th>
                                <th class="sticky-top bg-white">Burn
                                    <i class="bi bi-filter" onclick="sortTable(15, 'gameCommands')"></i>
                                </th>
                                <th class="sticky-top bg-white">Pool
                                    <i class="bi bi-filter" onclick="sortTable(16, 'gameCommands')"></i>
                                </th>
                                <th class="sticky-top bg-white">Blood
                                    <i class="bi bi-filter" onclick="sortTable(17, 'gameCommands')"></i>
                                </th>
                                <th class="sticky-top bg-white">Contest
                                    <i class="bi bi-filter" onclick="sortTable(18, 'gameCommands')"></i>
                                </th>
                                <th class="sticky-top bg-white">Disc
                                    <i class="bi bi-filter" onclick="sortTable(19, 'gameCommands')"></i>
                                </th>
                                <th class="sticky-top bg-white">Capacity
                                    <i class="bi bi-filter" onclick="sortTable(20, 'gameCommands')"></i>
                                </th>
                                <th class="sticky-top bg-white">Unlock
                                    <i class="bi bi-filter" onclick="sortTable(21, 'gameCommands')"></i>
                                </th>
                                <th class="sticky-top bg-white">Lock
                                    <i class="bi bi-filter" onclick="sortTable(22, 'gameCommands')"></i>
                                </th>
                                <th class="sticky-top bg-white">Order
                                    <i class="bi bi-filter" onclick="sortTable(23, 'gameCommands')"></i>
                                </th>
                                <th class="sticky-top bg-white">Show
                                    <i class="bi bi-filter" onclick="sortTable(24, 'gameCommands')"></i>
                                </th>
                                <th class="sticky-top bg-white">Shuffle
                                    <i class="bi bi-filter" onclick="sortTable(25, 'gameCommands')"></i>
                                </th>
                                <th class="sticky-top bg-white">Transfer
                                    <i class="bi bi-filter" onclick="sortTable(26, 'gameCommands')"></i>
                                </th>
                                <th class="sticky-top bg-white">Rfg
                                    <i class="bi bi-filter" onclick="sortTable(27, 'gameCommands')"></i>
                                </th>
                                <th class="sticky-top bg-white">Path
                                    <i class="bi bi-filter" onclick="sortTable(28, 'gameCommands')"></i>
                                </th>
                                <th class="sticky-top bg-white">Sect
                                    <i class="bi bi-filter" onclick="sortTable(29, 'gameCommands')"></i>
                                </th>
                                <th class="sticky-top bg-white">Clan
                                    <i class="bi bi-filter" onclick="sortTable(30, 'gameCommands')"></i>
                                </th>
                                <th class="sticky-top bg-white">Open
                                    <i class="bi bi-filter" onclick="sortTable(31, 'gameCommands')"></i>
                                </th>
                            </tr>
                            </thead>
                            <tbody></tbody>
                        </table>
                    </div>
                </div>

            </div>

            </div>
        </div>
    </div>
</div>
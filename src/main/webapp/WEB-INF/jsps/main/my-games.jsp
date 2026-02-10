<div class="card shadow">
    <div class="card-header bg-body-secondary d-flex justify-content-between align-items-baseline">
        <h5>Active games:</h5>
        <div class="d-flex justify-content-between align-items-baseline">
            <button class="btn btn-sm btn-outline-secondary border p-2" style="font-size: 0.6rem;" onclick="clearBellsActive()">
                <i class="bi bi-bell-slash"></i>
            </button>
            <div class="form-check form-switch">
                <input class="form-check-input" type="checkbox" role="switch" id="myGamesDetailedMode"
                       onchange="toggleDetailedMode(this);">
                <label class="form-check-label" for="myGamesDetailedMode">Details</label>
            </div>
        </div>
    </div>
    <ul class="list-group list-group-flush" id="myGames">
    </ul>
</div>
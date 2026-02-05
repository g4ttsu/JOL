<div class="card shadow panel-default notes" id="notesCard">
    <div class="card-header bg-body-secondary justify-content-between d-flex align-items-center">
        <span>Notes</span>
        <div>
            <button class="border-0 shadow rounded-pill bg-light player-only float-end" onclick="toggleNotes();"><i
                    class="bi bi-info-lg me-2"></i>Deck
            </button>
            <button class="border-0 shadow rounded-pill bg-light" onclick="togglePlayedCards();"><i
                    class="bi bi-hourglass-split"></i>Played Cards
            </button>
        </div>
    </div>
    <div class="card-body p-0">
        <label for="globalNotes" class="d-none"></label>
        <textarea id="globalNotes" class="form-control scrollable" onblur="sendGlobalNotes();"
                  placeholder="Global Notes"></textarea>
        <label for="privateNotes" class="d-none"></label>
        <textarea id="privateNotes" class="form-control scrollable player-only" onblur="sendPrivateNotes();"
                  placeholder="Private Notes"></textarea>
    </div>
</div>
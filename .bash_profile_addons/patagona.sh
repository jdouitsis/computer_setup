
pfbs() {
    . venv/bin/activate;
    export GOOGLE_APPLICATION_CREDENTIALS="./firebase_service_account_key.json"; 
    uvicorn main:app --reload --port 8001;
}

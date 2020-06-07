import { createStore, applyMiddleware } from "redux"
import thunk from "redux-thunk"

const initialState = {
    deals: []
}

function rootReducer(state, action) {
    console.log(action.type);
    switch (action.type) {
        case "GET_DEALS_SUCCESS": 
            return { deals: action.json.deals };
    }
    return state;
}

export default function configureStore() {
    const store = createStore(
        rootReducer, 
        initialState,
        applyMiddleware(thunk)
    );
    return store;
}

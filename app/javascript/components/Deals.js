import React from "react"
import { connect } from 'react-redux'
import { createStructuredSelector } from 'reselect'
import {
  BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, Legend,
} from 'recharts';

const GET_DEALS_REQUEST = 'GET_DEALS_REQUEST';
const GET_DEALS_SUCCESS = 'GET_DEALS_SUCCESS';

function getDeals() {
  return dispatch => {
    dispatch({ type: GET_DEALS_REQUEST});
    return fetch('v1/deals.json')
      .then(response => response.json())
      .then(json => dispatch(getDealsSuccess(json)))
      .catch(error => console.log(error));
  };
};

export function getDealsSuccess(json) {
  return {
    type: GET_DEALS_SUCCESS,
    json
  }
}


class Deals extends React.Component {
  componentDidMount() {
    this.props.getDeals()
  }

  render () {
    const { deals } = this.props;
    return (
      <React.Fragment>
        <BarChart
        width={1000}
        height={500}
        data={deals}
        margin={{
          top: 5, right: 30, left: 20, bottom: 5,
        }}
        barSize={20}
      >
        <XAxis dataKey="name" scale="point" padding={{ left: 10, right: 10 }} />
        <YAxis /> 
        <Tooltip />
        <Legend />
        <CartesianGrid strokeDasharray="3 3" />
        <Bar dataKey="summed_value" fill="#8884d8" background={{ fill: '#eee' }} />
      </BarChart>
      </React.Fragment>
    );
  }
}

const structuredSelector = createStructuredSelector({
  deals: state => state.deals
})

const mapDispatchToProps = { getDeals }

export default connect(structuredSelector, mapDispatchToProps)(Deals)

import React from 'react'
import { render } from 'react-dom'
import Highcharts from 'highcharts'
import HighchartsReact from 'highcharts-react-official'

const options = {
  title: {
    text: 'Current Standings',
  },
  series: [{
    name: 'Will',
    data: [1, 4, 6, 7, 8]
  }, {
    name: 'Derek',
    data: [2, 8, 8, 12, 15]
  }, {
    name: 'Stephen',
    data: [4, 6, 7, 10, 13]
  }, {
    name: 'Dinshaw',
    data: [3, 6, 8, 9, 14]
  }]
}

const Chart = () => {
  return (
    <div>
      <HighchartsReact
        highcharts={Highcharts}
        options={options}
      />
    </div>
  );
}

document.addEventListener('DOMContentLoaded', () => {
  render(<Chart />, document.querySelector('#react-target'))
})

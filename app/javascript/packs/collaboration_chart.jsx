import React, {useState, useEffect} from 'react'
import { render } from 'react-dom'
import Highcharts from 'highcharts'
import HighchartsReact from 'highcharts-react-official'

const Chart = () => {
  const [series, setSeries] = useState(null);

  useEffect(() => {
    fetch('/api/v1/pointed_events.json', {
      headers: {
        'Content-Type': 'application/json'
      },
    })
      .then(res => res.json())
      .then((response) => {
        const data = response.chart_data.map((collaborator) => {
          return {
            name: collaborator.email,
            data: collaborator.points
          }
        });
        setSeries(data);
      })
      .catch(console.error);
  }, []);

  if (!series) {
    return <p>Loading...</p>
  }

  const options = {
    title: {
      text: 'Current Standings',
    },
    series,
  };

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

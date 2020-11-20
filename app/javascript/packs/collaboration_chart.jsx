import React, {useState, useEffect, useRef} from 'react'
import { render } from 'react-dom'
import { format, sub } from 'date-fns';
import Highcharts from 'highcharts'
import HighchartsReact from 'highcharts-react-official'

/* const mockResponse = {
  chart_data: [
    {email: "homer@simpsons.com", points: [0,1,4,6,9]},
    {email: "marge@simpsons.com", points: [1,5,6,6,10]},
    {email: "bart@simpsons.com", points: [0,3,4,6,7]},
    {email: "derek@hotelengine.com", points: [2,2,2,2,2]},
  ],
  start_date: "2020-11-18",
} */

const Chart = () => {
  const [series, setSeries] = useState([]);
  const chartContainer = useRef(null);

  useEffect(() => {
    chartContainer.current.chart.showLoading();
    fetch('/api/v1/pointed_events.json', {
      headers: {
        'Content-Type': 'application/json'
      },
    })
      .then(res => res.json())
      .then((response) => {
        const chartData = response.chart_data;
        const startDate = response.start_date; // 2020-11-18
        const year = parseInt(startDate.split('-')[0], 10);
        const month = parseInt(startDate.split('-')[1], 10) - 1;
        const day = parseInt(startDate.split('-')[2], 10);

        const data = chartData.map((collaborator) => {
          return {
            name: collaborator.email,
            data: collaborator.points,
            pointStart: Date.UTC(year, month, day),
            pointInterval: 24 * 3600 * 1000 // one day
          }
        });
        setSeries(data);
        chartContainer.current.chart.hideLoading();
      })
      .catch(console.error);
  }, []);

  const options = {
    credits: {
      enabled: false
    },
    title: null,
    chart: {
      zoomType: 'xy',
      style: {
        fontFamily: 'helvetica'
      }
    },
    series,
    tooltip: {
      formatter: function () {
          const points = this.y;
          const endDate = format(this.x, 'E, LLL do');
          const startDate = format(sub(this.x, { days: 5 }), 'E, LLL do');
          return `
            ${this.series.getName()} <br />
            ${points} pts ${startDate} - ${endDate}
          `;
      }
    },
    plotOptions: {
      series: {
          cursor: 'pointer',
          point: {
              events: {
                  click: function (evt) {
                      const name = evt.point.series.getName();
                      const url = `/pointed_events?&q[user_email_eq]=${name}`;
                      location.href = url;
                  }
              }
          }
      }
  },
    xAxis: {
      type: 'datetime',
      labels: {
        formatter: function() {
          return Highcharts.dateFormat('%a %d %b', this.value);
        }
      }
    },
    yAxis: {
      title: {
        text: 'Points'
      }
    }
  };

  return (
    <div>
      <HighchartsReact
        highcharts={Highcharts}
        options={options}
        ref={chartContainer}
      />
    </div>
  );
}

document.addEventListener('DOMContentLoaded', () => {
  if (document.querySelector('#react-target')) {
    render(<Chart />, document.querySelector('#react-target'))
  }
})

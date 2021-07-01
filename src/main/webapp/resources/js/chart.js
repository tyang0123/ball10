const Chart = require('@toast-ui/chart/dist/toastui-chart.min.js');

const Chart = require('@toast-ui/chart');  // ./dist/toastui-chart.js

import { BarChart } from '@toast-ui/chart';  // ./dist/esm/index.js

import BarChart from '@toast-ui/chart/bar';

const el = document.getElementById('chart-area');
const data = {
    categories: ['Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
    series: [
        {
            name: 'Budget',
            data: [5000, 3000, 5000, 7000, 6000, 4000, 1000]
        },
        {
            name: 'Income',
            data: [8000, 4000, 7000, 2000, 6000, 3000, 5000]
        },
        {
            name: 'Expenses',
            data: [4000, 4000, 6000, 3000, 4000, 5000, 7000]
        },
        {
            name: 'Debt',
            data: [3000, 4000, 3000, 1000, 2000, 4000, 3000]
        }
    ]
};
const options = {
    chart: { width: 700, height: 400 },
};

chart.barChart({ el, data, options });

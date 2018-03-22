const Data = {
  chart_type: $('#type_change span:visible')[0].getAttribute('name'),
  source_id: $('#source_id').val(),
  empty_data: [{date: moment().format('YYYY-MM-DD'), faces: 0, clicks: 0, impressions: 0}],
  start_at: moment(),
  end_at: moment(),
  chart: '',
};

const ChartMixin = {
  mounted(){
    this.chart_init();
    this.daterange_init();
    this.time_display();
    this.fetch_chart();
  },
  methods: {
    fetch_chart(){
      const self = this;

      $.ajax({
        url: document.URL,
        type: 'post',
        data: {
          start_at: self.start_at.format('YYYY-MM-D'),
          end_at: self.end_at.format('YYYY-MM-D'),
          type: self.chart_type,
          source_id: self.source_id,
        },
      }).done( ({data, last_time_calculated_at}) => {
        if(data.length === 0) {
          data = self.empty_data;
          $.bootstrapGrowl('No Data!', {
            type: 'danger',
            align: 'right',
            offset: {from: 'bottom', amount: 30}
          });
        }
        self.chart.setData(data);
        $('#last_time_calculated_at').html(last_time_calculated_at)
      });
    },
    time_display(){
      $('#time-daterange span').html(`${this.start_at.format('MMMM D, YYYY')} - ${this.end_at.format('MMMM D, YYYY')}`);
    },
    daterange_init(){
      const self = this;

      $('#time-daterange').daterangepicker({
        ranges: {
          'today': [moment(), moment()],
          'yesterday': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
          'past_7_days': [moment().subtract(6, 'days'), moment()],
          'past_1_month': [moment().subtract(29, 'days'), moment()],
          'this_month': [moment().startOf('month'), moment().endOf('month')],
          'last_month': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
        },
        startDate: moment(),
        endDate: moment()
      },function (start, end) {
        self.start_at = start;
        self.end_at = end;
        self.time_display();
        self.fetch_chart();
      });
    },
    chart_init(){
      this.chart = new Morris.Line({
        element: 'charge-time-chart',
        resize: true,
        data: '',
        xkey: ['date'],
        ykeys: ['faces', 'impressions', 'clicks'],
        labels: ['Faces', 'Impressions', 'Clicks'],
        lineColors: ['#a0d0e0', '#ff925c', '#959595'],
        hideHover: 'auto'
      });
    },
    change_type(e){
      $(e.target.parentElement).find('span').toggleClass('hidden');
      this.chart_type = $('#type_change span:visible')[0].getAttribute('name')
    }
  },
  watch: {
    source_id(){
      this.fetch_chart();
    },
    chart_type(){
      this.fetch_chart();
    }
  }
}


export {ChartMixin, Data}
import Vue from 'vue/dist/vue.esm';
import _   from 'lodash';

new Vue({
  el: '#no_money_managers',
  data: {
    filter_money: '',
  },
  methods:{
    fetch_manager(){
      $.ajax({
        url: document.URL,
        data: {filter_money: this.filter_money},
        dataType: 'json'
      }).done((data) => {
        $('#no_money_managers .mt-actions').html('')
        data.forEach(e => {
          $('#no_money_managers .mt-actions').append(
            "<div class='mt-action mt-action-inline'>\
                  <div class='mt-action-body'>\
                    <div class='mt-action-row'>\
                      <div class='mt-action-info '>\
                        <div class='mt-action-details '>\
                          <p class='mt-action-desc' style='color:#00c0ef;'>\
                            <span style='font-weight: bold; font-size: 38px;" + (e.remaining_sum <= 0 ? 'color: rgba(255, 0, 0, 0.67)' : '') + "'>"+e.remaining_sum+"</span>\
                            <span style='white-space: nowrap;'>Remaining Sum</span>\
                          </p>\
                          <span class='mt-action-author' style='color: #00c0ef; font-weight: lighter;'>\
                          ["+e.id+"] "+e.name+"\
                          </span>\
                        </div>\
                      </div>\
                    </div>\
                  </div>\
                 </div>"
          )
        })
      })
    }
  },
  watch: {
    filter_money: _.debounce(function () {
      this.fetch_manager()
    }, 500)
  }
});

new Vue({
  el: '#date_end_ads',
  data: {
    start_at: moment(),
    end_at: moment(),
  },
  mounted(){
    this.daterange_init()
    this.time_display()
  },
  methods:{
    fetch_ads(){
      $.ajax({
        url: document.URL,
        data: {
          start_at: this.start_at.format(),
          end_at: this.end_at.format()
        },
        dataType: 'json'
      }).done((data) => {
        $('#date_end_ads .mt-actions').html('')
        data.forEach(e => {
          $('#date_end_ads .mt-actions').append(
            "<div class='mt-action mt-action-inline'>\
                  <div class='mt-action-body'>\
                    <div class='mt-action-row'>\
                      <div class='mt-action-info '>\
                        <div class='mt-action-details '>\
                          <p class='mt-action-desc' style='color:#00c0ef;'>\
                            <span style='font-weight: bold; font-size: 28px;'>"+e.end_at+"</span>\
                            <span style='white-space: nowrap;'>End At</span>\
                          </p>\
                          <span class='mt-action-author' style='color: #00c0ef; font-weight: lighter;'>\
                          ["+e.id+"] "+e.name+"\
                          </span>\
                        </div>\
                      </div>\
                    </div>\
                  </div>\
                 </div>"
          )
        })
      })
    },
    daterange_init(){
      $('#time-daterange').daterangepicker({
        ranges: {
          'tomorrow': [moment().add(1, 'days').startOf('month'), moment().add(1, 'days').endOf('day')],
          'next_7_days': [moment(), moment().add(6, 'days').endOf('day')],
          'next_1_month': [moment(), moment().add(29, 'days').endOf('day')],
          'this_month': [moment().startOf('month'), moment().endOf('month')],
          'last_month': [moment().add(1, 'month').startOf('month'), moment().add(1, 'month').endOf('month')]
        },
        startDate: moment(),
        endDate: moment()
      },(start, end) => {
        this.start_at = start;
        this.end_at = end;
        this.time_display();
        this.fetch_ads();
      });
    },
    time_display(){
      $('#time-daterange span').html(`${this.start_at.format('MMMM D, YYYY')} - ${this.end_at.format('MMMM D, YYYY')}`);
    }
  }
});

import Vue                 from 'vue/dist/vue.esm';
import {ChartMixin, Data}  from '../../../mixins/chart';

$.ajaxSetup({
  headers: { 'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content') }
});

new Vue({
  el: '#app',
  data: Data,
  mixins: [ChartMixin]
});
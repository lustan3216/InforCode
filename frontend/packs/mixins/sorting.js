export default {
  created() {
    let self = this;
    $(document).on('click','.sorting',function(e){
      let target = e.target;
      let name = target.attributes.name.value
      let current_page = self.$parent.pagination.current_page
      let sorting = {name: name, taxis: 'desc'}

      target.classList.remove('sorting');
      $('.sorting_desc, .sorting_asc')
        .removeClass('sorting_asc')
        .removeClass('sorting_desc')
        .addClass('sorting');

      target.classList.add('sorting_desc');
      self.$parent.fetchSources(current_page, null, sorting)
    });
    $(document).on('click','.sorting_desc',function(e){
      let target = e.target;
      let name = target.attributes.name.value
      let current_page = self.$parent.pagination.current_page
      let sorting = {name: name, taxis: 'asc'}

      target.classList.remove('sorting_desc');
      target.classList.add('sorting_asc');
      self.$parent.fetchSources(current_page, null, sorting)
    });
    $(document).on('click','.sorting_asc',function(e){
      let target = e.target;
      let name = target.attributes.name.value
      let current_page = self.$parent.pagination.current_page
      let sorting = {name: name, taxis: 'desc'}

      target.classList.remove('sorting_asc');
      target.classList.add('sorting_desc');
      self.$parent.fetchSources(current_page, null, sorting)
    })
  }
}
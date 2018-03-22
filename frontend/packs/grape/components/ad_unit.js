import                     '../../vendor/qrcode';
import viewExtend  from './ad_unit/view_extend';
import modelExtend from './ad_unit/model_extend';

export default function (domComps, dModel, dView){

  domComps.addType('Ad Unit', {
    model: dModel.extend(
      Object.assign(
        {
          init() {
            this.ajaxAdUnit();
            this.listenTo(this, 'change:attributes', this.ajaxAdUnit);
          },
          defaults: Object.assign({}, dModel.prototype.defaults, {
            traits: [{
              type: 'select',
              label: 'Ad Unit',
              name: 'data-ad-unit-id',
              options: (function(){
                const option = $('#gjs').data('ad_unit_option').map(e=> (
                  { value: `${e.id} `, name: `[${e.id}] ${e.title}` }
                ));
                return [{ value: '', name: 'Select A Unit' },...option]
              })()
            }],
          })
        }, modelExtend
      )
      ,{
        isComponent: function(el) {
          if(el.tagName === 'DIV' && el.attributes.name && el.attributes.name.value === 'ad_unit'){
            return {type: 'Ad Unit'};
          }
        },
      }),

    view: dView.extend(Object.assign(
      {
        events: { click: 'show_ad' }
      }, viewExtend
    )),
  });
}
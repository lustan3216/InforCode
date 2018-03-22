export default function (domComps, dModel, dView){

  domComps.addType('Display Block', {
    model: dModel.extend({
      defaults: Object.assign({}, dModel.prototype.defaults, {
        traits: [],
      }),
    },{
      isComponent: function(el) {
        if(el.tagName === 'DIV' && el.attributes.name && el.attributes.name.value === 'display_block'){
          return {type: 'Trigger Block'};
        }
      }
    }),
    view: dView
  });

}

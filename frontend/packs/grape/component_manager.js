import adUnit       from './components/ad_unit'
import streaming    from './components/streaming'
import displayBlock from './components/display_block'

export default function (editor){
  var domComps = editor.DomComponents;
  var dType = domComps.getType('default');
  var dModel = dType.model;
  var dView = dType.view;

  adUnit(domComps, dModel, dView)
  streaming(domComps, dModel, dView)
  displayBlock(domComps, dModel, dView)
}



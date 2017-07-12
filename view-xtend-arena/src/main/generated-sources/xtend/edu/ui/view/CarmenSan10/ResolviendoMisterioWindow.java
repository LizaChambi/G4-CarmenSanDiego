package edu.ui.view.CarmenSan10;

import com.google.common.base.Objects;
import edu.ui.domain.AppModel.ExpedienteAppModel;
import edu.ui.domain.AppModel.LugarInteresAppModel;
import edu.ui.domain.AppModel.ResolverMisterioAppModel;
import edu.ui.domain.CarmenSan10.Caso;
import edu.ui.domain.CarmenSan10.Detective;
import edu.ui.domain.CarmenSan10.Expediente;
import edu.ui.domain.CarmenSan10.LugarDeInteres;
import edu.ui.domain.CarmenSan10.Pais;
import edu.ui.view.CarmenSan10.ExpedientesResolverMisterioView;
import edu.ui.view.CarmenSan10.LugaresWindow;
import edu.ui.view.CarmenSan10.OrdenArrestoWindow;
import edu.ui.view.CarmenSan10.ViajarWindow;
import org.eclipse.xtext.xbase.lib.ObjectExtensions;
import org.eclipse.xtext.xbase.lib.Procedures.Procedure1;
import org.uqbar.arena.bindings.ObservableValue;
import org.uqbar.arena.bindings.PropertyAdapter;
import org.uqbar.arena.layout.ColumnLayout;
import org.uqbar.arena.layout.HorizontalLayout;
import org.uqbar.arena.layout.VerticalLayout;
import org.uqbar.arena.widgets.Button;
import org.uqbar.arena.widgets.Control;
import org.uqbar.arena.widgets.Label;
import org.uqbar.arena.widgets.List;
import org.uqbar.arena.widgets.Panel;
import org.uqbar.arena.widgets.Selector;
import org.uqbar.arena.windows.SimpleWindow;
import org.uqbar.arena.windows.WindowOwner;
import org.uqbar.arena.xtend.ArenaXtendExtensions;
import org.uqbar.lacar.ui.model.Action;
import org.uqbar.lacar.ui.model.ControlBuilder;
import org.uqbar.lacar.ui.model.ListBuilder;
import org.uqbar.lacar.ui.model.bindings.Binding;

@SuppressWarnings("all")
public class ResolviendoMisterioWindow extends SimpleWindow<ResolverMisterioAppModel> {
  public ResolviendoMisterioWindow(final WindowOwner parent, final ResolverMisterioAppModel model) {
    super(parent, model);
  }
  
  public void createFormPanel(final Panel mainPanel) {
    String _tituloDelCaso = this.getModelObject().tituloDelCaso();
    String _plus = ("Resolviendo:" + _tituloDelCaso);
    this.setTitle(_plus);
    Panel _panel = new Panel(mainPanel);
    final Procedure1<Panel> _function = new Procedure1<Panel>() {
      public void apply(final Panel it) {
        VerticalLayout _verticalLayout = new VerticalLayout();
        it.setLayout(_verticalLayout);
        Panel _panel = new Panel(mainPanel);
        final Procedure1<Panel> _function = new Procedure1<Panel>() {
          public void apply(final Panel it) {
            HorizontalLayout _horizontalLayout = new HorizontalLayout();
            it.setLayout(_horizontalLayout);
            Panel _panel = new Panel(it);
            final Procedure1<Panel> _function = new Procedure1<Panel>() {
              public void apply(final Panel it) {
                Panel _panel = new Panel(it);
                final Procedure1<Panel> _function = new Procedure1<Panel>() {
                  public void apply(final Panel it) {
                    ColumnLayout _columnLayout = new ColumnLayout(2);
                    it.setLayout(_columnLayout);
                    Label _label = new Label(it);
                    final Procedure1<Label> _function = new Procedure1<Label>() {
                      public void apply(final Label it) {
                        it.setText("Estas en: ");
                      }
                    };
                    ObjectExtensions.<Label>operator_doubleArrow(_label, _function);
                    Label _label_1 = new Label(it);
                    final Procedure1<Label> _function_1 = new Procedure1<Label>() {
                      public void apply(final Label it) {
                        ObservableValue<Control, ControlBuilder> _value = it.<ControlBuilder>value();
                        ArenaXtendExtensions.operator_spaceship(_value, "nombrePaisActual");
                      }
                    };
                    ObjectExtensions.<Label>operator_doubleArrow(_label_1, _function_1);
                  }
                };
                final Panel titulo = ObjectExtensions.<Panel>operator_doubleArrow(_panel, _function);
                Button _button = new Button(it);
                final Procedure1<Button> _function_1 = new Procedure1<Button>() {
                  public void apply(final Button it) {
                    it.setCaption("Orden De Arresto");
                    final Action _function = new Action() {
                      public void execute() {
                        ResolviendoMisterioWindow.this.abrirOrdenDeArresto();
                      }
                    };
                    it.onClick(_function);
                  }
                };
                ObjectExtensions.<Button>operator_doubleArrow(_button, _function_1);
                Panel _panel_1 = new Panel(it);
                final Procedure1<Panel> _function_2 = new Procedure1<Panel>() {
                  public void apply(final Panel it) {
                    ColumnLayout _columnLayout = new ColumnLayout(2);
                    it.setLayout(_columnLayout);
                    Label _label = new Label(it);
                    final Procedure1<Label> _function = new Procedure1<Label>() {
                      public void apply(final Label it) {
                        ObservableValue<Control, ControlBuilder> _value = it.<ControlBuilder>value();
                        ArenaXtendExtensions.operator_spaceship(_value, "estadoDeLaOrdenDeArresto");
                        it.setFontSize(8);
                      }
                    };
                    ObjectExtensions.<Label>operator_doubleArrow(_label, _function);
                    Label _label_1 = new Label(it);
                    final Procedure1<Label> _function_1 = new Procedure1<Label>() {
                      public void apply(final Label it) {
                        it.setFontSize(8);
                        ObservableValue<Control, ControlBuilder> _value = it.<ControlBuilder>value();
                        ArenaXtendExtensions.operator_spaceship(_value, "ordenPara");
                      }
                    };
                    ObjectExtensions.<Label>operator_doubleArrow(_label_1, _function_1);
                  }
                };
                final Panel estadoDeLaOrden = ObjectExtensions.<Panel>operator_doubleArrow(_panel_1, _function_2);
                Button _button_1 = new Button(it);
                final Procedure1<Button> _function_3 = new Procedure1<Button>() {
                  public void apply(final Button it) {
                    it.setCaption("Viajar");
                    final Action _function = new Action() {
                      public void execute() {
                        ResolviendoMisterioWindow.this.abrirViajarAPais();
                      }
                    };
                    it.onClick(_function);
                  }
                };
                ObjectExtensions.<Button>operator_doubleArrow(_button_1, _function_3);
                Button _button_2 = new Button(it);
                final Procedure1<Button> _function_4 = new Procedure1<Button>() {
                  public void apply(final Button it) {
                    it.setCaption("Expedientes");
                    final Action _function = new Action() {
                      public void execute() {
                        ResolviendoMisterioWindow.this.verExpedientes();
                      }
                    };
                    it.onClick(_function);
                  }
                };
                ObjectExtensions.<Button>operator_doubleArrow(_button_2, _function_4);
              }
            };
            final Panel left = ObjectExtensions.<Panel>operator_doubleArrow(_panel, _function);
            Panel _panel_1 = new Panel(it);
            final Procedure1<Panel> _function_1 = new Procedure1<Panel>() {
              public void apply(final Panel it) {
                Label _label = new Label(it);
                _label.setText("Lugares:");
                Button _button = new Button(it);
                final Procedure1<Button> _function = new Procedure1<Button>() {
                  public void apply(final Button it) {
                    it.setCaption(ResolviendoMisterioWindow.this.getModelObject().getLugar1().nombre);
                    final Action _function = new Action() {
                      public void execute() {
                        ResolviendoMisterioWindow.this.abrirLugarDeInteres(ResolviendoMisterioWindow.this.getModelObject().getLugar1());
                      }
                    };
                    it.onClick(_function);
                  }
                };
                ObjectExtensions.<Button>operator_doubleArrow(_button, _function);
                Button _button_1 = new Button(it);
                final Procedure1<Button> _function_1 = new Procedure1<Button>() {
                  public void apply(final Button it) {
                    it.setCaption(ResolviendoMisterioWindow.this.getModelObject().getLugar2().nombre);
                    final Action _function = new Action() {
                      public void execute() {
                        ResolviendoMisterioWindow.this.abrirLugarDeInteres(ResolviendoMisterioWindow.this.getModelObject().getLugar2());
                      }
                    };
                    it.onClick(_function);
                  }
                };
                ObjectExtensions.<Button>operator_doubleArrow(_button_1, _function_1);
                Button _button_2 = new Button(it);
                final Procedure1<Button> _function_2 = new Procedure1<Button>() {
                  public void apply(final Button it) {
                    it.setCaption(ResolviendoMisterioWindow.this.getModelObject().getLugar3().nombre);
                    final Action _function = new Action() {
                      public void execute() {
                        ResolviendoMisterioWindow.this.abrirLugarDeInteres(ResolviendoMisterioWindow.this.getModelObject().getLugar3());
                      }
                    };
                    it.onClick(_function);
                  }
                };
                ObjectExtensions.<Button>operator_doubleArrow(_button_2, _function_2);
              }
            };
            final Panel right = ObjectExtensions.<Panel>operator_doubleArrow(_panel_1, _function_1);
          }
        };
        final Panel juego = ObjectExtensions.<Panel>operator_doubleArrow(_panel, _function);
        Panel _panel_1 = new Panel(mainPanel);
        final Procedure1<Panel> _function_1 = new Procedure1<Panel>() {
          public void apply(final Panel it) {
            VerticalLayout _verticalLayout = new VerticalLayout();
            it.setLayout(_verticalLayout);
            Label _label = new Label(it);
            _label.setText("Recorrido criminal:");
            Label _label_1 = new Label(it);
            final Procedure1<Label> _function = new Procedure1<Label>() {
              public void apply(final Label it) {
                ObservableValue<Control, ControlBuilder> _value = it.<ControlBuilder>value();
                ArenaXtendExtensions.operator_spaceship(_value, "paisesAcertados");
              }
            };
            ObjectExtensions.<Label>operator_doubleArrow(_label_1, _function);
            Label _label_2 = new Label(it);
            _label_2.setText("Destinos fallidos:");
            List<Pais> _list = new List<Pais>(mainPanel);
            final Procedure1<List<Pais>> _function_1 = new Procedure1<List<Pais>>() {
              public void apply(final List<Pais> it) {
                Binding<?, Selector<Pais>, ListBuilder<Pais>> _bindItemsToProperty = it.bindItemsToProperty("paisesFallidos");
                PropertyAdapter _propertyAdapter = new PropertyAdapter(Pais.class, "nombrePais");
                _bindItemsToProperty.setAdapter(_propertyAdapter);
              }
            };
            ObjectExtensions.<List<Pais>>operator_doubleArrow(_list, _function_1);
          }
        };
        final Panel estado = ObjectExtensions.<Panel>operator_doubleArrow(_panel_1, _function_1);
      }
    };
    final Panel generalPanel = ObjectExtensions.<Panel>operator_doubleArrow(_panel, _function);
  }
  
  public void abrirLugarDeInteres(final LugarDeInteres lugar) {
    Caso _caso = this.getModelObject().getCaso();
    Detective _detective = this.getModelObject().getDetective();
    final LugarInteresAppModel model = new LugarInteresAppModel(lugar, _caso, _detective);
    new LugaresWindow(this, model).open();
  }
  
  public void verExpedientes() {
    Expediente _expediente = this.getModelObject().getExpediente();
    String _tituloDelCaso = this.getModelObject().tituloDelCaso();
    final ExpedienteAppModel model = new ExpedienteAppModel(_expediente, _tituloDelCaso);
    new ExpedientesResolverMisterioView(this, model).open();
  }
  
  public void abrirViajarAPais() {
    ResolverMisterioAppModel _modelObject = this.getModelObject();
    new ViajarWindow(this, _modelObject).open();
  }
  
  public void abrirOrdenDeArresto() {
    ResolverMisterioAppModel _modelObject = this.getModelObject();
    new OrdenArrestoWindow(this, _modelObject).open();
  }
  
  public void destinosFallidos(final Panel panelPrincipal) {
    final Panel panelDestinosFallidos = new Panel(panelPrincipal);
    VerticalLayout _verticalLayout = new VerticalLayout();
    panelDestinosFallidos.setLayout(_verticalLayout);
    Label _label = new Label(panelDestinosFallidos);
    _label.setText("Destinos fallidos:");
    this.tablaDePaises(panelDestinosFallidos);
  }
  
  public Object tablaDePaises(final Panel panelPrincipal) {
    return null;
  }
  
  public String estadoDeLaOrdenDeArresto() {
    String _xifexpression = null;
    String _ordenDeArresto = this.getModelObject().getDetective().getOrdenDeArresto();
    boolean _equals = Objects.equal(_ordenDeArresto, "");
    if (_equals) {
      _xifexpression = "Sin emitir orden de arresto.";
    } else {
      String _ordenDeArresto_1 = this.getModelObject().getDetective().getOrdenDeArresto();
      _xifexpression = ("Orden ya emitida:" + _ordenDeArresto_1);
    }
    return _xifexpression;
  }
  
  public void addActions(final Panel actionsPanel) {
  }
}

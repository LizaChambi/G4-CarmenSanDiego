package edu.ui.view.CarmenSan10;

import edu.ui.domain.AppModel.MapamundiAppModel;
import edu.ui.domain.CarmenSan10.Caracteristicas;
import edu.ui.domain.CarmenSan10.Mapamundi;
import edu.ui.domain.CarmenSan10.Pais;
import edu.ui.view.CarmenSan10.EditarPaisWindows;
import edu.ui.view.CarmenSan10.NuevoPaisWindow;
import org.eclipse.xtext.xbase.lib.ObjectExtensions;
import org.eclipse.xtext.xbase.lib.Procedures.Procedure1;
import org.uqbar.arena.bindings.NotNullObservable;
import org.uqbar.arena.bindings.ObservableValue;
import org.uqbar.arena.layout.HorizontalLayout;
import org.uqbar.arena.widgets.Button;
import org.uqbar.arena.widgets.Control;
import org.uqbar.arena.widgets.Label;
import org.uqbar.arena.widgets.Panel;
import org.uqbar.arena.widgets.tables.Column;
import org.uqbar.arena.widgets.tables.Table;
import org.uqbar.arena.windows.SimpleWindow;
import org.uqbar.arena.windows.WindowOwner;
import org.uqbar.arena.xtend.ArenaXtendExtensions;
import org.uqbar.lacar.ui.model.Action;
import org.uqbar.lacar.ui.model.ControlBuilder;
import org.uqbar.lacar.ui.model.TableBuilder;
import org.uqbar.lacar.ui.model.bindings.ViewObservable;

@SuppressWarnings("all")
public class MapamundiWindow extends SimpleWindow<MapamundiAppModel> {
  public MapamundiWindow(final WindowOwner parent, final Mapamundi model) {
    super(parent, new MapamundiAppModel(model));
  }
  
  protected void createFormPanel(final Panel mainPanel) {
    this.setTitle("Mapamundi");
    Panel _panel = new Panel(mainPanel);
    final Procedure1<Panel> _function = new Procedure1<Panel>() {
      public void apply(final Panel it) {
        HorizontalLayout _horizontalLayout = new HorizontalLayout();
        it.setLayout(_horizontalLayout);
      }
    };
    final Panel general = ObjectExtensions.<Panel>operator_doubleArrow(_panel, _function);
    final NotNullObservable elementSelected = new NotNullObservable("itemSeleccionado");
    final Panel ladoIzq = new Panel(general);
    Table<Pais> _table = new Table<Pais>(ladoIzq, Pais.class);
    final Procedure1<Table<Pais>> _function_1 = new Procedure1<Table<Pais>>() {
      public void apply(final Table<Pais> it) {
        it.setHeight(600);
        it.setWidth(350);
        ViewObservable<Table<Pais>, TableBuilder<Pais>> _items = it.items();
        ArenaXtendExtensions.operator_spaceship(_items, "mapa.paises");
        ObservableValue<Control, ControlBuilder> _value = it.<ControlBuilder>value();
        ArenaXtendExtensions.operator_spaceship(_value, "itemSeleccionado");
      }
    };
    Table<Pais> table = ObjectExtensions.<Table<Pais>>operator_doubleArrow(_table, _function_1);
    Column<Pais> _column = new Column<Pais>(table);
    final Procedure1<Column<Pais>> _function_2 = new Procedure1<Column<Pais>>() {
      public void apply(final Column<Pais> it) {
        it.setTitle("Paises");
        it.setFixedSize(150);
        it.bindContentsToProperty("nombrePais");
      }
    };
    ObjectExtensions.<Column<Pais>>operator_doubleArrow(_column, _function_2);
    Button _button = new Button(ladoIzq);
    final Procedure1<Button> _function_3 = new Procedure1<Button>() {
      public void apply(final Button it) {
        it.setCaption("Eliminar");
        final Action _function = new Action() {
          public void execute() {
            MapamundiWindow.this.getModelObject().eliminarPaisSeleccionado();
          }
        };
        it.onClick(_function);
        it.<Object, ControlBuilder>bindEnabled(elementSelected);
      }
    };
    ObjectExtensions.<Button>operator_doubleArrow(_button, _function_3);
    Button _button_1 = new Button(ladoIzq);
    final Procedure1<Button> _function_4 = new Procedure1<Button>() {
      public void apply(final Button it) {
        it.setCaption("Editar");
        final Action _function = new Action() {
          public void execute() {
            MapamundiWindow.this.editarPais();
          }
        };
        it.onClick(_function);
        it.<Object, ControlBuilder>bindEnabled(elementSelected);
      }
    };
    ObjectExtensions.<Button>operator_doubleArrow(_button_1, _function_4);
    Button _button_2 = new Button(ladoIzq);
    final Procedure1<Button> _function_5 = new Procedure1<Button>() {
      public void apply(final Button it) {
        it.setCaption("Nuevo");
        final Action _function = new Action() {
          public void execute() {
            MapamundiWindow.this.agregarNuevoPais();
          }
        };
        it.onClick(_function);
      }
    };
    ObjectExtensions.<Button>operator_doubleArrow(_button_2, _function_5);
    final Panel ladoDer = new Panel(general);
    Panel _panel_1 = new Panel(ladoDer);
    final Procedure1<Panel> _function_6 = new Procedure1<Panel>() {
      public void apply(final Panel it) {
        HorizontalLayout _horizontalLayout = new HorizontalLayout();
        it.setLayout(_horizontalLayout);
      }
    };
    final Panel horPanel = ObjectExtensions.<Panel>operator_doubleArrow(_panel_1, _function_6);
    Label _label = new Label(horPanel);
    final Procedure1<Label> _function_7 = new Procedure1<Label>() {
      public void apply(final Label it) {
        it.setText("Nombre:");
      }
    };
    ObjectExtensions.<Label>operator_doubleArrow(_label, _function_7);
    Label _label_1 = new Label(horPanel);
    final Procedure1<Label> _function_8 = new Procedure1<Label>() {
      public void apply(final Label it) {
        ObservableValue<Control, ControlBuilder> _value = it.<ControlBuilder>value();
        ArenaXtendExtensions.operator_spaceship(_value, "itemSeleccionado.nombrePais");
      }
    };
    ObjectExtensions.<Label>operator_doubleArrow(_label_1, _function_8);
    Label _label_2 = new Label(ladoDer);
    _label_2.setText("Características");
    Table<Caracteristicas> _table_1 = new Table<Caracteristicas>(ladoDer, Caracteristicas.class);
    final Procedure1<Table<Caracteristicas>> _function_9 = new Procedure1<Table<Caracteristicas>>() {
      public void apply(final Table<Caracteristicas> it) {
        ViewObservable<Table<Caracteristicas>, TableBuilder<Caracteristicas>> _items = it.items();
        ArenaXtendExtensions.operator_spaceship(_items, "itemSeleccionado.caracteristicaPais");
        ObservableValue<Control, ControlBuilder> _value = it.<ControlBuilder>value();
        ArenaXtendExtensions.operator_spaceship(_value, "itemSeleccionado");
      }
    };
    Table<Caracteristicas> tableT = ObjectExtensions.<Table<Caracteristicas>>operator_doubleArrow(_table_1, _function_9);
    Column<Caracteristicas> _column_1 = new Column<Caracteristicas>(tableT);
    final Procedure1<Column<Caracteristicas>> _function_10 = new Procedure1<Column<Caracteristicas>>() {
      public void apply(final Column<Caracteristicas> it) {
        it.setTitle("Caraterísticas");
        it.setFixedSize(200);
        it.bindContentsToProperty("nombre");
      }
    };
    ObjectExtensions.<Column<Caracteristicas>>operator_doubleArrow(_column_1, _function_10);
    Label _label_3 = new Label(ladoDer);
    _label_3.setText("Conexiones");
    Table<Pais> _table_2 = new Table<Pais>(ladoDer, Pais.class);
    final Procedure1<Table<Pais>> _function_11 = new Procedure1<Table<Pais>>() {
      public void apply(final Table<Pais> it) {
        ViewObservable<Table<Pais>, TableBuilder<Pais>> _items = it.items();
        ArenaXtendExtensions.operator_spaceship(_items, "itemSeleccionado.paisesConexionAerea");
        ObservableValue<Control, ControlBuilder> _value = it.<ControlBuilder>value();
        ArenaXtendExtensions.operator_spaceship(_value, "itemSeleccionado");
      }
    };
    Table<Pais> table2 = ObjectExtensions.<Table<Pais>>operator_doubleArrow(_table_2, _function_11);
    Column<Pais> _column_2 = new Column<Pais>(table2);
    final Procedure1<Column<Pais>> _function_12 = new Procedure1<Column<Pais>>() {
      public void apply(final Column<Pais> it) {
        it.setTitle("Conexiones");
        it.setFixedSize(200);
        it.bindContentsToProperty("nombrePais");
      }
    };
    ObjectExtensions.<Column<Pais>>operator_doubleArrow(_column_2, _function_12);
    Label _label_4 = new Label(ladoDer);
    _label_4.setText("Lugares De Interes");
    Table<Pais> _table_3 = new Table<Pais>(ladoDer, Pais.class);
    final Procedure1<Table<Pais>> _function_13 = new Procedure1<Table<Pais>>() {
      public void apply(final Table<Pais> it) {
        ViewObservable<Table<Pais>, TableBuilder<Pais>> _items = it.items();
        ArenaXtendExtensions.operator_spaceship(_items, "itemSeleccionado.lugares");
        ObservableValue<Control, ControlBuilder> _value = it.<ControlBuilder>value();
        ArenaXtendExtensions.operator_spaceship(_value, "itemSeleccionado");
      }
    };
    Table<Pais> table3 = ObjectExtensions.<Table<Pais>>operator_doubleArrow(_table_3, _function_13);
    Column<Pais> _column_3 = new Column<Pais>(table3);
    final Procedure1<Column<Pais>> _function_14 = new Procedure1<Column<Pais>>() {
      public void apply(final Column<Pais> it) {
        it.setTitle("Lugares");
        it.setFixedSize(200);
        it.bindContentsToProperty("nombreLugares");
      }
    };
    ObjectExtensions.<Column<Pais>>operator_doubleArrow(_column_3, _function_14);
  }
  
  public void agregarNuevoPais() {
    MapamundiAppModel _modelObject = this.getModelObject();
    Pais _pais = new Pais("");
    _modelObject.setItemSeleccionado(_pais);
    MapamundiAppModel _modelObject_1 = this.getModelObject();
    new NuevoPaisWindow(this, _modelObject_1).open();
  }
  
  public void editarPais() {
    MapamundiAppModel _modelObject = this.getModelObject();
    new EditarPaisWindows(this, _modelObject).open();
  }
  
  protected void addActions(final Panel actionsPanel) {
  }
}

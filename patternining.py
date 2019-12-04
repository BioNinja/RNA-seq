''' Create a simple stocks correlation dashboard.
Choose stocks to compare in the drop down widgets, and make selections
on the plots to update the summary and histograms accordingly.
.. note::
    Running this example requires downloading sample data. See
    the included `README`_ for more information.
Use the ``bokeh serve`` command to run the example by executing:
    bokeh serve stocks
at your command prompt. Then navigate to the URL
    http://localhost:5006/stocks
.. _README: https://github.com/bokeh/bokeh/blob/master/examples/app/stocks/README.md
'''
try:
    from functools import lru_cache
except ImportError:
    # Python 2 does stdlib does not have lru_cache so let's just
    # create a dummy decorator to avoid crashing
    print ("WARNING: Cache for this example is available on Python 3 only.")
    def lru_cache():
        def dec(f):
            def _(*args, **kws):
                return f(*args, **kws)
            return _
        return dec

from os.path import dirname, join

import pandas as pd

from bokeh.io import curdoc
from bokeh.layouts import row, column
from bokeh.models import ColumnDataSource
from bokeh.models.widgets import PreText, Select, TextInput
from bokeh.plotting import figure

DATA_DIR = join(dirname(__file__), 'tpm')

@lru_cache()
def load_tpm(tpms):
    fname = join(DATA_DIR, "tpms.csv")
    data = pd.read_csv(fname, header=True, index_col='gene_name')
    return data

@lru_cache()
def get_data(symbol, tpms):
    dat = load_tpm(tpms)
    tpm = dat.loc[symbol]
    return tpm

# set up widgets
#stats = PreText(text='', width=500)
symbol = TextInput(title="Gene Names input",  width=500)

# set up plots
source = ColumnDataSource(data=dict(d4=[], d8=[],concd4=[], concd8=[]))
source_static = ColumnDataSource(data=dict(conc=[], d4=[], d8=[]))
tools = 'pan,wheel_zoom,xbox_select,reset'

#correlation plot for d4, d8
corr = figure(plot_width=350, plot_height=350,
              tools='pan,wheel_zoom,box_select,reset')
corr.circle('d4', 'd8', size=2, source=source,
            selection_color="orange", alpha=0.6, nonselection_alpha=0.1, selection_alpha=0.4)

#line plot for day 4
tp1 = figure(plot_width=900, plot_height=200, tools=tools, x_axis_type='linear', active_drag="xbox_select")
tp1.line('conc', 'd4', source=source_static)
tp1.circle('concd4', 'd4', size=1, source=source, color=None, selection_color="orange")

#ts2 for day8
tp2 = figure(plot_width=900, plot_height=200, tools=tools, x_axis_type='linear', active_drag="xbox_select")
tp2.x_range = tp1.x_range
tp2.line('conc', 'd8', source=source_static)
tp2.circle('concd8', 'd8', size=1, source=source, color=None, selection_color="orange")

# set up callbacks
def update():
    sm = symbol.value.strip()
    d4 = get_data(sm, td4)
    d8 = get_data(sm,td8)

    source.data = dict(
        d4=d4.tolist(), 
        d8=d8.tolist(),
        concd4=d4.index.tolist(),
        concd8=d8.index.tolist()
        )
    source_static.data = dict(
        d4=d4.tolist(), 
        d8=d8.tolist(),
        concd4=d4.index.tolist(),
        concd8=d8.index.tolist()
        )

source.on_change('value', lambda attr, old, new: update())
# set up layout
widgets = column(symbol)
main_row = row(corr, widgets)
series = column(tp1, tp2)
layout = column(main_row, series)

# initialize
update()

curdoc().add_root(layout)
curdoc().title = "TPMs across Anterior and Posterior axis"
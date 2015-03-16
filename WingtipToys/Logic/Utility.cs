using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;

namespace WingtipToys.Logic
{
    public class Utility
    {
        public static IOrderedDictionary GetValues(GridViewRow row)
        {
            IOrderedDictionary values = new OrderedDictionary();
            foreach (DataControlFieldCell cell in row.Cells)
            {
                if (cell.Visible)
                {
                    // Extract values from the cell.
                    cell.ContainingField.ExtractValuesFromCell(values, cell, row.RowState, true);
                }
            }
            return values;
        }
    }
}
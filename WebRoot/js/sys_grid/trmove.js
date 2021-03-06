			var tbody, headRow;
            var bDragMode = false;
            var objDragItem;
            var arrHitTest = new Array();
            var iArrayHit = false;
            var ColumnCount = null;
            var mustRefresh = false;
            var dragColor = null;
            var hitColor = null;
            var HasTopMostPager = null;
            var PowerTable = null;
            //
            // Init function.. Fills out variables with data
            // loaded with oncontentready.
            //��table��ʼ��
            function initDragTable(table)
            {
            
                var i;
                
                PowerTable = table;
                
                if (dragColor == null) 
                    dragColor = "white";
                if (hitColor == null) 
                    hitColor = "lightblue";
                
                // get TBODY - take the first TBODY for the table
                tbody = PowerTable.tBodies[0];
                
                if (!tbody) 
                    return;
                
                // get THEAD - take the unique THEAD for the table
                var click = PowerTable.tHead;
                if (!click) 
                    return;
                
                
                // Determine the row to use (read from HasPager)
                if (HasTopMostPager == "true") 
                    headRow = click.children[1];
                else 
                    headRow = click.children[0];
                
                if (headRow.tagName != "TR") 
                    return;
                
                headRow.runtimeStyle.cursor = "hand"; //"move";
                ColumnCount = headRow.children.length;
                
                for (i = 0; i < ColumnCount; i++) 
                {
                    arrHitTest[i] = new Array();
                }
                
                
                var cx = 0;
                var cy = 0;
                var c;
                defaultTitleColor = headRow.children[0].currentStyle.backgroundColor;
                
                for (i = 0; i < ColumnCount; i++) 
                {
                
                    var clickCell = headRow.children[i];
                    clickCell.selectIndex = i;
                    c = clickCell.offsetParent;
                    
                    
                    if (cx == 0 && cy == 0) 
                    {
                        while (c.offsetParent != null) 
                        {
                            cy += c.offsetTop;
                            cx += c.offsetLeft;
                            c = c.offsetParent;
                        }
                    }
                    
                    arrHitTest[i][0] = cx + clickCell.offsetLeft;
                    arrHitTest[i][1] = cy + clickCell.offsetTop;
                    arrHitTest[i][2] = clickCell;
                    arrHitTest[i][3] = cx + clickCell.offsetLeft + clickCell.clientWidth;
                    
                    clickCell.attachEvent("onmousedown", onMouseDown);
                }
                
                PowerTable.attachEvent("onmousemove", onMouseMove);
                PowerTable.attachEvent("onmouseup", onMouseUp);
                
                ///////
                if (arrHitTest[0][0] == arrHitTest[0][3]) 
                    mustRefresh = true;
            }
            
            
            function InitHeader()
            {
                var cx = 0;
                var cy = 0;
                var c;
                
                for (i = 0; i < ColumnCount; i++) 
                {
                
                    var clickCell = headRow.children[i];
                    clickCell.selectIndex = i;
                    c = clickCell.offsetParent;
                    
                    if (cx == 0 && cy == 0) 
                    {
                        while (c.offsetParent != null) 
                        {
                            cy += c.offsetTop;
                            cx += c.offsetLeft;
                            c = c.offsetParent;
                        }
                    }
                    
                    arrHitTest[i][0] = cx + clickCell.offsetLeft;
                    arrHitTest[i][1] = cy + clickCell.offsetTop;
                    arrHitTest[i][2] = clickCell;
                    arrHitTest[i][3] = cx + clickCell.offsetLeft + clickCell.clientWidth;
                    
                }
            }
            
            
            function ChangeHeader(iChange)
            {
                for (var y = 0; y < arrHitTest.length; y++) 
                {
                    if (arrHitTest[y][2].currentStyle.backgroundColor == hitColor) 
                        arrHitTest[y][2].style.backgroundColor = defaultTitleColor;
                }
                
                if (iChange == "-1") 
                    return;
                
                arrHitTest[iChange][2].style.backgroundColor = hitColor;
            }
            
            function onMouseUp(e)
            {
                if (!bDragMode) 
                    return;
                bDragMode = false;
                
                var iSelected = objDragItem.selectIndex;
                
                objDragItem.removeNode(true);
                objDragItem = null;
                
                ChangeHeader(-1);
                
                if ((iArrayHit - 1) < 0 || iSelected < 0) 
                    return; // default faliure
                // iSelected is the 0-based index of the column being moved
                // (iArrayHit-1) is the 0-based index of the column being replaced
                CopyRow(iSelected, (iArrayHit - 1));
                
                // Reset our variables
                iSelected = 0;
                iArrayHit = -1;
            }
            
            function onMouseDown(e){
                // If the grid is contained in an invisible panel (other DHTML stuff)
                // the initialization step must be repeated to take real values
                if (mustRefresh) 
                {
                    InitHeader();
                    mustRefresh = false;
                }
                
                
                bDragMode = true;
                var src = e.srcElement;
                var c = e.srcElement;
                
                while (src.tagName != "TD") 
                    src = src.parentElement;
                
                // Create our header on the fly
                objDragItem = document.createElement("DIV");
                objDragItem.innerHTML = src.innerHTML;
                objDragItem.style.height = src.offsetParent.clientHeight;
                objDragItem.style.width = src.clientWidth;
                objDragItem.style.background = dragColor;
                objDragItem.style.fontColor = src.currentStyle.fontColor;
                objDragItem.style.position = "absolute";
                objDragItem.style.filter = "progid:DXImageTransform.Microsoft.Alpha(opacity=75)";
                objDragItem.selectIndex = src.selectIndex;
                objDragItem.style.border = "1 solid black";
                while (c.offsetParent != null) 
                {
                    objDragItem.style.y += c.offsetTop;
                    objDragItem.style.x += c.offsetLeft;
                    c = c.offsetParent;
                }
                
                objDragItem.style.borderStyle = "dashed";
                objDragItem.style.borderWidth = "1px";
                objDragItem.style.display = "none";
                
                src.insertBefore(objDragItem);
            }
            
            function onMouseMove(e)
            {
                if (!bDragMode || !objDragItem) 
                    return;
                
                // If we aren't dragging or our object is null, we return
                
                // Hardcoded value for height difference
                var midWObj = objDragItem.style.posWidth / 2;
                var midHObj = 12;
                
                // Save mouse's position in the document
                var intTop = e.clientY + document.body.scrollTop;
                var intLeft = e.clientX + document.body.scrollLeft;
                
                
                var cx = 0, cy = 0;
                var elCurrent = objDragItem.offsetParent;
                if (elCurrent != null) 
                {
                    while (elCurrent.offsetParent != null) 
                    {
                        cx += elCurrent.offsetTop;
                        cy += elCurrent.offsetLeft;
                        elCurrent = elCurrent.offsetParent;
                    }
                }
                
                objDragItem.style.pixelTop = intTop - cx - midHObj;
                objDragItem.style.pixelLeft = intLeft - cy - midWObj;
                
                
                if (objDragItem.style.display == "none") 
                    objDragItem.style.display = "";
                
                iArrayHit = CheckHit(intTop, intLeft, e);
                
                e.cancelBubble = false;
                e.returnValue = false;
            }
            
            function CheckHit(x, y, e)
            {
                midWObj = objDragItem.style.posWidth / 2;
                midHObj = 12;
                
                
                for (var i = 0; i < ColumnCount; i++) 
                {
                    if ((y) > (arrHitTest[i][0]) && (y) < (arrHitTest[i][3])) 
                    {
                        ChangeHeader(i);
                        return i + 1;
                    }
                }
                return -1;
            }
            
            //
            // Copy from row to row.. Does the Header also.
            //
            function CopyRow(from, to)
            {
                if (from == to) 
                    return;
                
                
                var origfrom = from;
                var origto = to;
                var iDiff = 0;
                
                if (from > to) 
                {
                
                    iDiff = from - to;
                    
                    var saveObj = headRow.children[from].innerHTML;
                    var saveWidth = headRow.children[from].width;
                    for (var i = 0; i < iDiff; i++) 
                    {
                        headRow.children[from].innerHTML = headRow.children[from - 1].innerHTML;
                        headRow.children[from].width = headRow.children[from - 1].width;
                        from--;
                    }
                    headRow.children[to].innerHTML = saveObj;
                    headRow.children[to].width = saveWidth;
                }
                else 
                {
                
                    iDiff = to - from;
                    
                    var saveObj = headRow.children[from].innerHTML;
                    var saveWidth = headRow.children[from].width;
                    
                    for (var i = 0; i < iDiff; i++) 
                    {
                        headRow.children[from].innerHTML = headRow.children[from + 1].innerHTML;
                        headRow.children[from].width = headRow.children[from + 1].width;
                        from++;
                    }
                    
                    headRow.children[to].innerHTML = saveObj;
                    headRow.children[to].width = saveWidth;
                }
                
                
                for (var i = 0; i < headRow.children.length; i++) 
                    headRow.children[i].selectIndex = i;
                
                
                InitHeader();
                for (var iRowInsert = 0; iRowInsert < tbody.rows.length; iRowInsert++) 
                {
                    from = origfrom;
                    to = origto;
                    if (from > to) 
                    {
                        iDiff = from - to;
                        var saveObj;
                        try 
                        {
                            saveObj = tbody.children[iRowInsert].children[from].innerHTML;
                        } 
                        catch (e) 
                        {
                            saveObj = null;
                        }
                        for (var i = 0; i < iDiff; i++) 
                        {
                            try 
                            {
                                tbody.children[iRowInsert].children[from].innerHTML = tbody.children[iRowInsert].children[from - 1].innerHTML;
                                from--;
                            } 
                            catch (e) 
                            {
                            }
                        }
                        if (saveObj != null) 
                            tbody.children[iRowInsert].children[to].innerHTML = saveObj;
                    }
                    else 
                    {
                        iDiff = to - from;
                        var saveObj;
                        try 
                        {
                            saveObj = tbody.children[iRowInsert].children[from].innerHTML;
                        } 
                        catch (e) 
                        {
                        }
                        for (var i = 0; i < iDiff; i++) 
                        {
                            try 
                            {
                                tbody.children[iRowInsert].children[from].innerHTML = tbody.children[iRowInsert].children[from + 1].innerHTML;
                                from++;
                            } 
                            catch (e) 
                            {
                            }
                        }
                        try 
                        {
                            tbody.children[iRowInsert].children[to].innerHTML = saveObj;
                        } 
                        catch (e) 
                        {
                        }
                    }
                }
                
                ////////
                
                var buf = "";
                for (var i = 0; i < headRow.children.length; i++) 
                {
                    var td = headRow.children[i];
                    tmp = td.innerHTML;
                    pos = tmp.indexOf("<");
                    if (pos > 0) 
                        tmp = tmp.substring(0, pos);
                    else 
                    {
                        if (pos == 0) 
                            tmp = td.innerText;
                    }
                    
                    buf += tmp;
                    if (i < headRow.children.length - 1) 
                        buf += ",";
                }
            }
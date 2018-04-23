param (
$search_phrase,
$replace_phrase,
$Xpath,
$file_path
)

Write-Output 'Путь к файлу: ' 
Write-Output $file_path

[xml]$xmlwhole = Get-Content $file_path

Write-Output "Содержимое файла: $($xmlwhole.OuterXml)" 

foreach ($xmlrow in $xmlwhole.SelectNodes($Xpath))
{
        if($xmlrow.GetType() -eq [System.Xml.XmlAttribute])
        {
                Write-Output "--------------Атрибут---------------------"
                Write-Output "До преобразования: $($xmlrow.Value)"
                $xmlrow.Value = $xmlrow.Value.Replace($search_phrase, $replace_phrase)
                Write-Output "После преобразования: $($xmlrow.Value)"
        }
        if($xmlrow.GetType() -eq [System.Xml.XmlElement])
        {
                Write-Output "--------------Узел---------------------"
                Write-Output "До преобразования: $($xmlrow.InnerXML)"
                $xmlrow.InnerXML = $xmlrow.InnerXML.Replace($search_phrase, $replace_phrase)
                Write-Output "После преобразования: $($xmlrow.InnerXML)"
        }
}
$xmlwhole.Save($file_path)
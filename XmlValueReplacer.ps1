param (
$search_phrase,
$replace_phrase,
$Xpath,
$file_path
)

Write-Output '���� � �����: ' 
Write-Output $file_path

[xml]$xmlwhole = Get-Content $file_path

Write-Output "���������� �����: $($xmlwhole.OuterXml)" 

foreach ($xmlrow in $xmlwhole.SelectNodes($Xpath))
{
        if($xmlrow.GetType() -eq [System.Xml.XmlAttribute])
        {
                Write-Output "--------------�������---------------------"
                Write-Output "�� ��������������: $($xmlrow.Value)"
                $xmlrow.Value = $xmlrow.Value.Replace($search_phrase, $replace_phrase)
                Write-Output "����� ��������������: $($xmlrow.Value)"
        }
        if($xmlrow.GetType() -eq [System.Xml.XmlElement])
        {
                Write-Output "--------------����---------------------"
                Write-Output "�� ��������������: $($xmlrow.InnerXML)"
                $xmlrow.InnerXML = $xmlrow.InnerXML.Replace($search_phrase, $replace_phrase)
                Write-Output "����� ��������������: $($xmlrow.InnerXML)"
        }
}
$xmlwhole.Save($file_path)